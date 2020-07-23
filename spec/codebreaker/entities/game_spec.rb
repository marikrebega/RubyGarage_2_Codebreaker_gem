# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Codebreaker::Entities::Game do
  subject(:game) { described_class.new }

  let(:lose_result) { '-+++' }
  let(:start_code) { '1111' }
  let(:hints_array) { [1, 2] }
  let(:valid_name) { 'a' * rand(3..20) }
  let(:code) { [1, 1, 1, 1] }
  let(:win_code) do
    Array.new(Codebreaker::Entities::Game::DIGITS_COUNT,
              Codebreaker::Entities::Processor::MATCHED_DIGIT_CHAR)
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

  context 'when #start_process method' do
    it do
      process = game.instance_variable_get(:@process)
      game.instance_variable_set(:@code, win_code)
      expect(process).to receive(:secret_code_proc).with(win_code.join, start_code)
      game.start_process(start_code)
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
