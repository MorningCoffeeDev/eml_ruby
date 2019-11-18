# typed: true
# frozen_string_literal: true

module EML
  class Model
    extend T::Sig

    def self.fields(fields)
      const_set(:FIELDS, fields.freeze)
      fields.each do |response_name, local_name|
        local_name ||= response_name
        __send__(:attr_reader, :"#{local_name}")
      end
    end

    sig { params(raw_values: T::Hash[String, T.untyped]).void }
    def initialize(raw_values)
      self.class::FIELDS.each do |response_name, local_name|
        local_name ||= response_name
        value = field_value(response_name, raw_values[response_name])
        instance_variable_set(:"@#{local_name}", value)
      end
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
