# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Codebreaker::Entities::Renderer do
  subject(:renderer) { described_class.new }

  let(:code) { '1111' }

  context 'when #message method' do
    it 'return puts I18n' do
      msg = :start_message
      expect(I18n).to receive(:t).with(msg, {})
      renderer.message(msg)
    end
  end

  context 'when #start_message method' do
    it 'return start_message' do
      expect(renderer).to receive(:message).with(:start_message)
      renderer.start_message
    end
  end

  context 'when #rules method' do
    it 'return rules' do
      expect(renderer).to receive(:message).with(:rules)
      renderer.rules
    end
  end

  context 'when #goodbye_message method' do
    it 'return goodbye_message' do
      expect(renderer).to receive(:message).with(:goodbye_message)
      renderer.goodbye_message
    end
  end

  context 'when #save_results_message method' do
    it 'return save_results_message' do
      expect(renderer).to receive(:message).with(:save_results_message)
      renderer.save_results_message
    end
  end

  context 'when #win_game_message method' do
    it 'return win_game_message' do
      expect(renderer).to receive(:message).with(:win_game_message)
      renderer.win_game_message
    end
  end

  context 'when #round_message method' do
    it 'return promt_to_enter_secret_code_hint_exit' do
      expect(renderer).to receive(:message).with(:round_message)
      renderer.round_message
    end
  end

  context 'when #lost_game_message method' do
    it 'return lost_game_message' do
      expect(renderer).to receive(:message).with(:lost_game_message, code: code)
      renderer.lost_game_message(code)
    end
  end

  context 'when #no_hints_message? method' do
    it 'return no_hints_message?' do
      expect(renderer).to receive(:message).with(:have_no_hints_message)
      renderer.no_hints_message?
    end
  end

  context 'when #print_hint_number method' do
    it 'return print_hint_number' do
      expect(renderer).to receive(:message).with(:print_hint_number, code: code)
      renderer.print_hint_number(code)
    end
  end

  context 'when #registration_name_emptyness_error method' do
    it 'return registration_name_emptyness_error' do
      expect(renderer).to receive(:message).with(:registration_name_emptyness_error)
      renderer.registration_name_emptyness_error
    end
  end

  context 'when #registration_name_length_error method' do
    it 'return registration_name_length_error' do
      expect(renderer).to receive(:message).with(:registration_name_length_error)
      renderer.registration_name_length_error
    end
  end

  context 'when #command_error method' do
    it 'return command_error' do
      expect(renderer).to receive(:message).with(:command_error)
      renderer.command_error
    end
  end

  context 'when #command_length_error method' do
    it 'return command_length_error' do
      expect(renderer).to receive(:message).with(:command_length_error)
      renderer.command_length_error
    end
  end

  context 'when #command_int_error method' do
    it 'return command_int_error' do
      expect(renderer).to receive(:message).with(:command_int_error)
      renderer.command_int_error
    end
  end
end
