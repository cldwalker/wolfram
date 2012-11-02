module Wolfram
  class State
    attr_reader :name, :input

    def self.collection(xml, options = {})
      Nokogiri::XML(xml.to_s).search('state').map {|s_xml|
        new(s_xml['name'], options.merge(:input => s_xml['input']))
      }
    end

    def initialize(name, options = {})
      @query = options[:query]
      @input = options[:input]
      @name = name
    end

    def to_query(key)
      Util.to_query(name, key)
    end

    def to_s
      "[#{name}...]"
    end

    def inspect
      "#<State: #{to_s}>"
    end

    def requery
      podstate = @query.params[:podstate] ? [@query.params[:podstate], input] : input
      Query.new(@query.input, @query.options.merge(:podstate => podstate))
    end

    def refetch
      requery.fetch
    end
  end
end
