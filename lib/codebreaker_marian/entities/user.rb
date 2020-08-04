# frozen_string_literal: true

module Codebreaker
  module Entities
    class User
      include Validator
      USERNAME_CONSTRAINTS = { min: 3, max: 20 }.freeze

      attr_reader :name

      def initialize(name)
        @name = name
        validate
      end

      private

      def validate
        check_type(@name, String)
        check_length(@name, USERNAME_CONSTRAINTS)
      end
    end
  end
end
