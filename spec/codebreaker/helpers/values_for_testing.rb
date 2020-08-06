# frozen_string_literal: true

# Module for auxiliary values for testing
module ValuesForTesting
  def standard_file_name
    'data.yml'
  end

  def standard_directory_name
    'database'
  end

  def standart_matched_digit_char
    '+'
  end

  def standard_user_constraints
    { min: 3, max: 20 }
  end

  def standard_difficulty_values
    {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }
  end

  def standard_game_numbers_count
    4
  end
end
