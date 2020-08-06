# frozen_string_literal: true

module Codebreaker
  module Entities
    class Processor
      MATCHED_DIGIT_CHAR = '+'
      UNMATCHED_DIGIT_CHAR = '-'
      WRONG_DIGIT_CHAR = ' '

      attr_reader :guess, :code, :result

      def secret_code_proc(code, guess)
        @code = code.split('')
        @guess = guess.split('')
        answer = handle_matched_digits.join + handle_matched_digits_with_wrong_position.join
        (code.length - answer.length).times { answer << WRONG_DIGIT_CHAR }
        answer
      end

      private

      def handle_matched_digits
        code.map.with_index do |_, index|
          next unless code[index] == guess[index]

          @guess[index], @code[index] = nil
          MATCHED_DIGIT_CHAR
        end
      end

      def handle_matched_digits_with_wrong_position
        guess.compact.map do |number|
          next unless @code.include?(number)

          @code.delete_at(code.index(number))
          UNMATCHED_DIGIT_CHAR
        end
      end
    end
  end
end
