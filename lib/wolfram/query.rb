require 'open-uri'

module Wolfram
  # When given an input, appid and other query params, creates a Result object
  class Query
    attr_accessor :input, :options, :appid, :query_uri

    def self.fetch(uri)
      open(uri).read
    end

    def initialize(input, options = {})
      @input = input
      @appid = options.delete(:appid) || Wolfram.appid || raise("No APPID set")
      @query_uri = options.delete(:query_uri) || Wolfram.query_uri
      @options = options
    end

    # explicitly fetch the result
    def fetch
      @result = Result.new(self.class.fetch(uri), :query => self)
    end

    def result
      @result ||= fetch
    end

    # the uri that this query will issue a get request to
    def uri(hash=params)
      "#{query_uri}?#{Util.to_param(hash)}"
    end

    def params
      options.merge(:input => input, :appid => appid)
    end

    def inspect
      out = "q: \"#{input}\""
      out << " #{options[:podstate]}" if options[:podstate]
      out << " (assuming #{options[:assumption]})" if options[:assumption]
      out << ", a: #{result.datatypes}" if @result
      out
    end
  end
end
