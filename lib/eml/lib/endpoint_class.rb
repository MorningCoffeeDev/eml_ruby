# typed: strict
# frozen_string_literal: true

module EML
  class EndpointClass
    extend T::Sig

    def self.call(class_type:, resource_class:, endpoint:)
      new(
        class_type: class_type,
        resource_class: resource_class,
        endpoint: endpoint
      ).call
    end

    def initialize(class_type:, resource_class:, endpoint:)
      @class_type = class_type
      @resource_class = resource_class
      @endpoint = endpoint
    end

    def call
      Object.const_get(class_name) if Object.const_defined?(class_name)
    end

    private

    def class_name
      @class_name ||= begin
        name_parts = @resource_class.name.split("::")
        name = name_parts[0..-2] << @class_type
        name << name_parts.last
        name << action_class_name
        name.join("::")
      end
    end

    def action_class_name
      @endpoint.capitalize.sub(/s$/, "")
    end
  end
end
