# typed: strict
# frozen_string_literal: true

module EML
  class EndpointClass
    extend T::Sig

    sig do
      params(class_type: String, resource_class: T.untyped, endpoint: String).
        returns(T.untyped)
    end
    def self.call(class_type:, resource_class:, endpoint:)
      new(
        class_type: class_type,
        resource_class: resource_class,
        endpoint: endpoint
      ).call
    end

    sig do
      params(class_type: String, resource_class: T.untyped, endpoint: String).
        void
    end
    def initialize(class_type:, resource_class:, endpoint:)
      @class_type = T.let(class_type, String)
      @resource_class = T.let(resource_class, T.untyped)
      @endpoint = T.let(endpoint, String)
      @class_name = T.let(nil, T.nilable(String))
    end

    sig { returns(T.untyped) }
    def call
      Object.const_get(class_name) if Object.const_defined?(class_name)
    end

    private

    sig { returns(String) }
    def class_name
      @class_name ||= begin
        name_parts = @resource_class.name.split("::")
        name = name_parts[0..-2] << @class_type
        name << name_parts.last
        name << action_class_name
        name.join("::")
      end
    end

    sig { returns(String) }
    def action_class_name
      @endpoint.capitalize.sub(/s$/, "")
    end
  end
end
