# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Codebreaker::Entities::DataStorage do
  subject(:data_storage) { described_class.new }

  let(:path) { 'database/data_test.yml' }
  let(:test_object) do
    {
      name: 'Denis',
      difficulty: Codebreaker::Entities::Game::DIFFICULTIES.keys.first,
      all_attempts: 15,
      attempts_used: 15,
      all_hints: 2,
      hints_used: 0
    }
  end

  before do
    File.new(path, 'w+')
    stub_const('Codebreaker::Entities::DataStorage::FILE_NAME', 'database/data_test.yml')
  end

  after { File.delete(path) }

  context 'when testing #storage_exist?' do
    it 'checks existence of file' do
      expect(data_storage.storage_exist?).to eq true
    end
  end

  context 'when testing #save_game_result' do
    it 'saves result' do
      data_storage.create
      expect(data_storage).to receive(:save).with(data_storage.load.push(test_object))
      data_storage.save_game_result(test_object)
    end
  end
end
