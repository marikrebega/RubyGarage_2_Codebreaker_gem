# frozen_string_literal: true

module Codebreaker
  module Validator
    DataValidError = Class.new(StandardError)

    def check_type(data, check_type)
      raise DataValidError, 'unexpected_type' unless data.instance_of? check_type
    end

    def check_length(data, check)
      raise DataValidError, 'unexpected_length' unless (check[:min]..check[:max]).cover? data.length
    end
  end
end
