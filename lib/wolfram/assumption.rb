module Wolfram
  class Assumption
    include XmlContainer
    include Enumerable
    extend Util

    delegate :[], :each, :to => :values

    def self.collection(xml, options = {})
      Nokogiri::XML(xml.to_s).search('assumptions').search('assumption').map {|a_xml| new(a_xml, options)}
    end

    attr_reader :values
    def initialize(xml, options = {})
      @query = options[:query]
      @xml = Nokogiri::XML(xml.to_s).search('assumption').first
      @xml or raise MissingNodeError, "<assumption> node missing from xml: #{xml[0..20]}..."
      extend Util.module_get(Assumption, @xml['type'])
      @values = Value.collection(@xml, options)
    end

    def name
      xml['type']
    end

    def to_s
      name + ": " + values.map(&:desc).join(', ')
    end

    def inspect
      "#<#{to_s}>"
    end

    class Value
      include XmlContainer

      def self.collection(xml, options = {})
        Nokogiri::XML(xml.to_s).search('value').map {|v_xml| new(v_xml, options)}
      end

      def initialize(xml, options = {})
        @query = options[:query]
        @xml = Nokogiri::XML(xml.to_s).search('value').first
        @xml or raise MissingNodeError, "<value> node missing from xml: #{xml[0..20]}..."
      end

      def inspect
        "#<#{to_s}>"
      end

      def to_s
        input
      end

      def requery
        Query.new(@query.input, @query.options.merge(:assumption => self))
      end

      def refetch
        requery.fetch
      end

      def to_query(key)
        Util.to_query(input, key)
      end
    end
  end
end
