# frozen_string_literal: true

module Vacations
  module Rules
    class BaseRule
      attr_accessor :entity

      def self.verify(entity)
        new(entity).verify!
      end

      def initialize(entity)
        @entity = entity
      end
    end
  end
end
