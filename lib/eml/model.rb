# typed: true
# frozen_string_literal: true

require "json"

module EML
  class Model
    extend T::Sig
    extend T::Helpers
    abstract!

    sig do
      params(
        fields: T.any(T::Hash[String, T.untyped], T::Array[String])
      ).void
    end
    def self.fields(fields)
      const_set(:FIELDS, fields.freeze)
      enumerate_fields do |_, local_name|
        __send__(:attr_reader, :"#{local_name}")
      end
    end

    sig { void }
    def self.enumerate_fields
      const_get(:FIELDS).each do |response_name, local_name|
        local_name ||= response_name.to_sym
        yield(response_name, local_name)
      end
    end

    sig { params(raw_values: T::Hash[String, T.untyped]).void }
    def initialize(raw_values)
      self.class.enumerate_fields do |response_name, local_name|
        value = field_value(response_name, raw_values[response_name])
        instance_variable_set(:"@#{local_name}", value)
      end
    end

    sig { returns(T::Hash[Symbol, T.untyped]) }
    def to_h
      ModelHash.(self)
    end

    sig { params(_args: T.nilable(Array)).returns(String) }
    def to_json(*_args)
      to_h.to_json
    end

    protected

    sig { params(name: String, raw_value: T.untyped).returns(T.untyped) }
    def field_value(name, raw_value)
      return raw_value unless name.match?(/(Date|Time)$/)
      return raw_value if raw_value.nil? || raw_value.empty?

      Time.parse(raw_value)
    end
  end
end
