# frozen_string_literal: true

RSpec.describe Codebreaker::Entities::Statistics do
  subject(:statistics) { described_class.new }

  context 'when testing #stats method' do
    let(:player_1) do
      {
        name: '',
        difficulty: Codebreaker::Entities::Game::DIFFICULTIES.keys.first,
        all_attempts: 15,
        attempts_used: 10,
        all_hints: 2,
        hints_used: 0
      }
    end
    let(:player_2) do
      {
        name: '',
        difficulty: Codebreaker::Entities::Game::DIFFICULTIES.keys.first,
        all_attempts: 15,
        attempts_used: 15,
        all_hints: 2,
        hints_used: 1
      }
    end
    let(:player_3) do
      {
        name: '',
        difficulty: Codebreaker::Entities::Game::DIFFICULTIES.keys.first,
        all_attempts: 15,
        attempts_used: 5,
        all_hints: 2,
        hints_used: 0
      }
    end

    let(:player_4) do
      {
        name: '',
        difficulty: Codebreaker::Entities::Game::DIFFICULTIES.keys.last,
        all_attempts: 5,
        attempts_used: 3,
        all_hints: 1,
        hints_used: 0
      }
    end

    let(:player_5) do
      {
        name: '',
        difficulty: Codebreaker::Entities::Game::DIFFICULTIES.keys.last,
        all_attempts: 5,
        attempts_used: 1,
        all_hints: 1,
        hints_used: 1
      }
    end

    let(:player_6) do
      {
        name: '',
        difficulty: Codebreaker::Entities::Game::DIFFICULTIES.keys.last,
        all_attempts: 5,
        attempts_used: 3,
        all_hints: 1,
        hints_used: 1
      }
    end

    it 'returns stats' do
      list = [player_1, player_2, player_3, player_4, player_5, player_6]
      expected_value = [player_5, player_4, player_6, player_3, player_1, player_2]
      expect(statistics.stats(list)).to eq expected_value
    end
  end
end
