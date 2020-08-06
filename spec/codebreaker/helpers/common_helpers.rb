# frozen_string_literal: true

# Module for auxiliary functions for testing
module CommonHelpers
  def random_number_by_range(from = 0, to = 9)
    rand(from..to)
  end

  def random_str_by_range_length(from, to)
    Array.new(rand(from..to)) { random_number_by_range }.join
  end
end
