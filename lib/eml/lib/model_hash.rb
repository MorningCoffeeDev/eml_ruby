# typed: strict
# frozen_string_literal: true

module EML
  class ModelHash
    extend T::Sig

    sig { params(model: EML::Model).returns(T::Hash[Symbol, T.untyped]) }
    def self.call(model)
      new(model).call
    end

    sig { params(model: EML::Model).void }
    def initialize(model)
      @model = model
      @hash = {}
    end

    sig { returns(T::Hash[Symbol, T.untyped]) }
    def call
      @model.class.enumerate_fields do |_, local_name|
        value = @model.public_send(local_name)
        add_value(local_name, value)
      end

      @hash
    end

    private

    sig { params(name: Symbol, value: T.untyped).void }
    def add_value(name, value)
      @hash[name] = stored_value(value)
    end

    sig { params(value: T.untyped).returns(T.untyped) }
    def stored_value(value)
      if value.is_a?(Array)
        array_value(value)
      elsif value.respond_to?(:to_h)
        value.to_h
      else
        value
      end
    end

    sig { params(value: Array).returns(Array) }
    def array_value(value)
      value.each_with_object([]) do |item, array|
        array << stored_value(item)
      end
    end
  end
end
