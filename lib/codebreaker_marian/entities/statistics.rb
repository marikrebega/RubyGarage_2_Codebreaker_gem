# frozen_string_literal: true

module Codebreaker
  module Entities
    class Statistics
      def stats(list)
        difficulties = list.group_by { |score| score[:difficulty] }
        Game::DIFFICULTIES.keys.reverse.reduce([]) do |sorted_difficulties, difficulty_name|
          if difficulties[difficulty_name]
            sorted_difficulties + stats_sort(difficulties[difficulty_name])
          else
            sorted_difficulties
          end
        end
      end

      private

      def stats_sort(scores)
        scores.sort_by! { |score| [score[:attempts_used], score[:hints_used]] }
      end
    end
  end
end
