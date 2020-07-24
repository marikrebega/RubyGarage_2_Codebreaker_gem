# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Codebreaker::Entities::Menu do
  subject(:menu) { described_class.new }

  let(:hints_array) { [1, 2] }
  let(:code) { [1, 2, 3, 4] }
  let(:command) { '1111' }
  let(:valid_name) { 'a' * rand(3..20) }
  let(:invalid_name) { 'a' * rand(0..2) }
  let(:statistics) { menu.instance_variable_get(:@statistics) }
  let(:list) do
    [{
      name: valid_name,
      difficulty: Codebreaker::Entities::Game::DIFFICULTIES.keys.first.to_s,
      all_attempts: 15,
      attempts_used: 15,
      all_hints: 2,
      hints_used: 0
    }]
  end

  context 'when testing #game_menu method' do
    it 'works with choice_options' do
      expect(menu.renderer).to receive(:start_message)
      allow(menu).to receive(:ask)
      allow(menu).to receive(:choice_menu_process).once
      menu.game_menu
    end
  end

  context 'when testing #rules' do
    it 'calls rules message' do
      expect(menu.renderer).to receive(:rules)
      allow(menu).to receive(:game_menu)
      menu.send(:rules)
    end
  end

  context 'when testing #start method' do
    it do
      expect(menu).to receive(:registrate_user)
      allow(menu).to receive(:level_choice)
      allow(menu).to receive(:game_process)
      menu.send(:start)
    end
  end

  context 'when testing #stats method' do
    it 'returns stats' do
      expect(menu.storage).to receive(:load) { list }
      allow(statistics).to receive(:stats)
      allow(menu).to receive(:render_stats)
      allow(menu).to receive(:game_menu)
      menu.send(:stats)
    end
  end

  context 'when testing #save_result method' do
    it 'expexts the choice of user' do
      expect(menu).to receive(:ask).with(:save_result_message) { Codebreaker::Entities::Menu::CHOOSE_COMMANDS[:yes] }
      menu.instance_variable_set(:@name, valid_name)
      allow(menu.game).to receive(:to_h).with(valid_name).and_return({})
      allow(menu.storage).to receive(:save_game_result).with({})
      menu.send(:save_result)
    end
  end

  context 'when testing #registration method' do
    it 'set name' do
      expect(menu).to receive(:ask).with(:registration).and_return(valid_name)
      menu.send(:registrate_user)
    end
  end

  context 'when testing #name_valid? method' do
    it 'returns true' do
      expect(menu.send(:name_valid?, valid_name)).to be true
    end

    it 'returns false' do
      expect(menu.send(:name_valid?, invalid_name)).to be false
    end
  end

  context 'when testing #level_choice method' do
    let(:difficulties) { Codebreaker::Entities::Game::DIFFICULTIES.keys.join(' | ') }

    it 'returns #generate_game' do
      level = Codebreaker::Entities::Game::DIFFICULTIES.keys.first
      expect(menu).to receive(:ask).with(:hard_level, levels: difficulties) { level }
      allow(menu).to receive(:generate_game).with(Codebreaker::Entities::Game::DIFFICULTIES[level.to_sym])
      menu.send(:level_choice)
    end

    it 'returns #game_menu' do
      exit = Codebreaker::Entities::Menu::COMMANDS[:exit]
      expect(menu).to receive(:ask).with(:hard_level, levels: difficulties) { exit }
      allow(menu).to receive(:game_menu)
      menu.send(:level_choice)
    end

    it 'returns #command_error' do
      expect(menu).to receive(:ask).with(:hard_level, levels: difficulties) { command }
      allow(menu.renderer).to receive(:command_error)
      allow(menu).to receive(:loop).and_yield
      menu.send(:level_choice)
    end
  end

  context 'when testing #choice_code_process method' do
    it 'returns #take_a_hint!' do
      menu.instance_variable_set(:@guess, Codebreaker::Entities::Menu::HINT_COMMAND)
      expect(menu).to receive(:hint_process)
      menu.send(:choice_code_process)
    end

    it 'returns #game_menu' do
      menu.instance_variable_set(:@guess, Codebreaker::Entities::Menu::COMMANDS[:exit])
      expect(menu).to receive(:game_menu)
      menu.send(:choice_code_process)
    end

    it 'returns #handle_command' do
      menu.instance_variable_set(:@guess, command)
      expect(menu).to receive(:handle_command)
      menu.send(:choice_code_process)
    end
  end

  context 'when testing #choice_menu_process' do
    %i[rules stats start].each do |command|
      it "returns ##{command}" do
        expect(menu).to receive(command)
        menu.send(:choice_menu_process, Codebreaker::Entities::Menu::COMMANDS[command])
      end
    end

    it 'returns #exit_from_game' do
      expect(menu).to receive(:exit_from_game)
      menu.send(:choice_menu_process, Codebreaker::Entities::Menu::COMMANDS[:exit])
    end

    it 'returns #command_error' do
      expect(menu.renderer).to receive(:command_error)
      allow(menu).to receive(:game_menu)
      menu.send(:choice_menu_process, command)
    end
  end

  context 'when testing #exit_from_game method' do
    it 'returns message' do
      expect(menu.renderer).to receive(:goodbye_message)
      allow(menu).to receive(:exit)
      menu.send(:exit_from_game)
    end
  end

  context 'when testing #hint_process method' do
    it 'returns no_hints_message?' do
      menu.game.instance_variable_set(:@hints, [])
      expect(menu.renderer).to receive(:no_hints_message?)
      menu.send(:hint_process)
    end
  end

  context 'when testing #generate_game method' do
    it do
      difficulty = Codebreaker::Entities::Game::DIFFICULTIES[:easy]
      expect(menu.game).to receive(:generate).with(difficulty)
      allow(menu.renderer).to receive(:message).with(:difficulty,
                                                     hints: difficulty[:hints], attempts: difficulty[:attempts])
      menu.send(:generate_game, difficulty)
    end
  end

  context 'when testing #handle_lose method' do
    it do
      expect(menu.renderer).to receive(:lost_game_message).with(menu.game.code)
      allow(menu).to receive(:game_menu)
      menu.send(:handle_lose)
    end
  end

  context 'when testing #handle_win method' do
    it do
      expect(menu.renderer).to receive(:win_game_message)
      allow(menu).to receive(:save_result)
      allow(menu).to receive(:game_menu)
      menu.send(:handle_win)
    end
  end

  context 'when testing #game_process method' do
    it 'returns #handle_win' do
      menu.game.instance_variable_set(:@attempts, Codebreaker::Entities::Game::DIFFICULTIES[:easy][:attempts])
      expect(menu).to receive(:ask) { command }
      allow(menu.game).to receive(:win?).with(command).and_return(true)
      allow(menu).to receive(:handle_win)
      menu.send(:game_process)
    end

    it 'retuns #handle_lose' do
      menu.game.instance_variable_set(:@attempts, 0)
      expect(menu).to receive(:handle_lose)
      menu.send(:game_process)
    end
  end

  context 'when testing #ask method' do
    it 'retuns msg' do
      phrase_key = :rules
      expect(menu.renderer).to receive(:message).with(phrase_key, {})
      allow(menu).to receive(:gets).and_return('')
      menu.send(:ask, phrase_key)
    end
  end
end
