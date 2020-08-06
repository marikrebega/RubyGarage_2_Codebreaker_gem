# frozen_string_literal: true

RSpec.describe Codebreaker::Entities::DataStorage do
  include ValuesForTesting

  subject(:data_storage) { described_class.new }

  let(:file_path) { 'database' }
  let(:file_name) { 'data.yml' }
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
    Dir.mkdir(file_path) unless Dir.exist?(file_path)
    File.new(File.join(file_path, file_name), 'w+')
    stub_const('Codebreaker::Entities::Game::DIFFICULTIES', standard_difficulty_values)
    stub_const('Codebreaker::Entities::DataStorage::FILE_NAME', standard_file_name)
    stub_const('Codebreaker::Entities::DataStorage::FILE_DIRECTORY', standard_directory_name)
  end

  after do
    File.delete(File.join(file_path, file_name))
    Dir.delete(file_path)
  end

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
