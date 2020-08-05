# frozen_string_literal: true

RSpec.describe Codebreaker::Entities::Processor do
  subject(:processor) { described_class.new }

  context 'when testing #secret_code_proc method' do
    codes = [{ code: '6543', guess: '5643', answer: '++--' },
             { code: '6543', guess: '6411', answer: '+-' },
             { code: '6543', guess: '6544', answer: '+++' },
             { code: '6543', guess: '3456', answer: '----' },
             { code: '6543', guess: '6666', answer: '+' },
             { code: '6543', guess: '2666', answer: '-' },
             { code: '6543', guess: '2222', answer: '' },
             { code: '6666', guess: '1661', answer: '++' },
             { code: '1234', guess: '3124', answer: '+---' },
             { code: '1234', guess: '1524', answer: '++-' },
             { code: '1234', guess: '1234', answer: '++++' }]
    codes.each do |test_data|
      it "tests that #{test_data[:code]} equals to #{test_data[:answer]}" do
        expect(processor.secret_code_proc(test_data[:code], test_data[:guess])).to eq test_data[:answer]
      end
    end
  end
end
