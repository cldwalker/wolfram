module Wolfram
  class HashPresenter
    attr_reader :result

    def initialize(result)
      @result = result
    end

    def to_hash
      {
        :pods => pods_to_hash,
        :assumptions => assumptions_to_hash
      }
    end

    private

    def pods_to_hash
      pods.inject Hash.new do |hash, pod|
        hash.update pod.title => pod.subpods.map(&:plaintext)
      end
    end

    def assumptions_to_hash
      assumptions.inject Hash.new do |hash, assumption|
        hash.update assumption.name => assumption.values.map(&:desc)
      end
    end

    def method_missing(method, *args, &block)
      if result.respond_to? method
        result.send(method, *args, &block)
      else
        super
      end
    end
  end
end
