# frozen_string_literal: true

RSpec.describe Codebreaker::Entities::Game do
  include ValuesForTesting

  subject(:game) { described_class.new }

  let(:lose_result) { UNMATCHED_DIGIT_CHAR + MATCHED_DIGIT_CHAR * 3 }
  let(:start_code) { '1' * Codebreaker::Entities::Game::DIGITS_COUNT }
  let(:hints_array) { [1, 2] }
  let(:min) { Codebreaker::Entities::User::USERNAME_CONSTRAINTS[:min] }
  let(:max) { Codebreaker::Entities::User::USERNAME_CONSTRAINTS[:max] }
  let(:valid_name) { 'a' * rand(min..max) }
  let(:code) { [1, 1, 1, 1] }

  before do
    stub_const('Codebreaker::Entities::User::USERNAME_CONSTRAINTS', standard_user_constraints)
    stub_const('Codebreaker::Entities::Game::DIFFICULTIES', standard_difficulty_values)
    stub_const('Codebreaker::Entities::Game::DIGITS_COUNT', standard_game_numbers_count)
    stub_const('Codebreaker::Entities::Processor::MATCHED_DIGIT_CHAR', standart_matched_digit_char)
  end

  context 'when testing #take_a_hint! method' do
    it 'returnes last el of hints array' do
      game.instance_variable_set(:@hints, hints_array)
      expected_value = game.hints.last
      expect(game.take_a_hint!).to eq expected_value
    end
  end

  context 'when #generate_secret_code method' do
    it 'checks that number mathes regex template' do
      secret_code = game.send(:generate_secret_code).join
      expect(secret_code).to match(/^[1-6]{#{Codebreaker::Entities::Game::DIGITS_COUNT}}$/)
    end
  end

  context 'when #generate method' do
    it do
      difficulty = Codebreaker::Entities::Game::DIFFICULTIES[:easy]
      expect(game).to receive(:generate_secret_code).and_return(code)
      game.generate(difficulty)
    end
  end

  context 'when used #decrease_attempts! method' do
    it 'decreases attempts by one when used' do
      game.instance_variable_set(:@attempts, 3)
      expect { game.decrease_attempts! }.to change(game, :attempts).by(-1)
    end
  end

  context 'when testing #hints_spent? method' do
    it 'returns true' do
      game.instance_variable_set(:@hints, [])
      expect(game.hints_spent?).to be true
    end

    it 'returns false' do
      game.instance_variable_set(:@hints, [1, 2])
      expect(game.hints_spent?).to be false
    end
  end

  context 'when testing #to_h method' do
    it 'returns hash' do
      game.instance_variable_set(:@difficulty, Codebreaker::Entities::Game::DIFFICULTIES[:easy])
      game.instance_variable_set(:@attempts, 2)
      game.instance_variable_set(:@hints, hints_array)
      expect(game.to_h(valid_name)).to be_an_instance_of(Hash)
    end
  end
end
