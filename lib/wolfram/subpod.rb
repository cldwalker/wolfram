module Wolfram
  class Subpod
    include XmlContainer

    def self.collection(xml, options = {})
      Nokogiri::XML(xml.to_s).search('subpod').map {|s_xml| new(s_xml, options) }
    end

    def initialize(xml, options = {})
      @query = options[:query]
      @xml = Nokogiri::Slop(xml.to_s).search('subpod').first
      @xml or raise MissingNodeError, "<subpod> node missing from xml: #{xml[0..20]}..."
    end

    def plaintext
      (e = xml.plaintext) && e.text
    end

    def img
      xml.img
    end
  end
end
