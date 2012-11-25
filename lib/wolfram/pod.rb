module Wolfram
  class Pod
    include XmlContainer
    include Enumerable
    extend Util

    delegate :[], :each, :to => :subpods

    def self.collection(xml, options = {})
      Nokogiri::XML(xml.to_s).search('pod').map {|p_xml| new(p_xml, options)}
    end

    attr_reader :subpods, :query, :states
    def initialize(xml, options = {})
      @query = options[:query]
      @xml = Nokogiri::XML(xml.to_s).search('pod').first
      @subpods = Subpod.collection(@xml.search('subpod'), options)
      @states = State.collection(@xml.search('states'), options)
      @xml or raise MissingNodeError, "<pod> node missing from xml: #{xml[0..20]}..."
      types.each {|type| extend type}
    end

    def to_s
      "#{title}: #{structured? ? plaintext : "'#{markup[0..20]}...'"} #{states.join(", ") if states.any?}"
    end

    def inspect
      "#<#{scanner}: #{to_s}>"
    end

    def types
      @types ||= scanner.split(',').map {|type| Util.module_get(Result, type)}
    end

    def plaintext
      (e = subpods.detect(&:plaintext)) && e.plaintext
    end

    def img
      (e = subpods.detect(&:plaintext)) && e.img
    end

    def markup
      @markup ||= (xml.search('markup').text || '')
    end

    def structured?
      subpods.any?
    end
  end
end


