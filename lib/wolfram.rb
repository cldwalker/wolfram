require 'nokogiri'
require 'wolfram/xml_container'
require 'wolfram/hash_presenter'
require 'wolfram/util'
require 'wolfram/query'
require 'wolfram/result'
require 'wolfram/pod'
require 'wolfram/subpod'
require 'wolfram/state'
require 'wolfram/assumption'

module Wolfram
  extend self

  class MissingNodeError < RuntimeError; end

  DefaultQueryURI = 'http://api.wolframalpha.com/v2/query'

  attr_accessor :appid, :query_uri

  def query_uri
    @query_uri ||= DefaultQueryURI
  end

  def query(input, options = {})
    Query.new(input, options)
  end

  def fetch(input, options = {})
    query(input, options).fetch
  end

  def run(argv=ARGV)
    puts cli_output(argv)
  rescue MissingNodeError
    warn "Wolfram Error: Invalid response - #{$!.message}"
  rescue RuntimeError
    warn "Wolfram Error: #{$!.message}"
  end

  private

  def cli_output(argv)
    if argv.empty?
      'Usage: wolfram QUERY'
    else
      fetch(argv.join(' ')).inspect
    end
  end
end

Wolfram.appid = ENV['WOLFRAM_APPID']
