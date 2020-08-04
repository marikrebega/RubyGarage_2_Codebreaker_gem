# frozen_string_literal: true

module Codebreaker
  module Validator
    def check_type(data, check_type)
      raise TypeError, 'unexpected_type' unless data.instance_of? check_type
    end

    def check_length(data, check)
      raise ArgumentError, 'unexpected_length' unless (check[:min]..check[:max]).cover? data.length
    end
  end
end
