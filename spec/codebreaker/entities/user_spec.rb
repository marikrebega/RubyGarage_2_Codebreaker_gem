# frozen_string_literal: true

RSpec.describe Codebreaker::Entities::User do
  include ValuesForTesting
  include CommonHelpers

  describe 'USERNAME_CONSTRAINTS constant' do
    let(:constant) { described_class::USERNAME_CONSTRAINTS }

    it 'contains ":min" key' do
      expect(constant).to have_key(:min)
    end

    it 'contains ":max" key' do
      expect(constant).to have_key(:max)
    end

    it 'values contains positive integers' do
      expect(constant.values).to all(be_instance_of(Integer).and(be > 0))
    end

    it 'value ":max" greater than ":min"' do
      expect(constant[:min]).to be < constant[:max]
    end
  end

  describe '#initialize' do
    subject(:user) { described_class.new(user_name) }

    before { stub_const("#{described_class}::USERNAME_CONSTRAINTS", standard_user_constraints) }

    context 'when an instance is created with correct user name in argument' do
      let(:user_name) do
        random_str_by_range_length(
          standard_user_constraints[:min],
          standard_user_constraints[:max]
        )
      end

      it 'successful creation' do
        expect { user }.not_to raise_error
      end
    end

    context 'when instantiated with non-string username in argument' do
      let(:user_name) { 1 }

      it 'exсeption "unexpected_type"' do
        expect { user }.to raise_error(described_class::DataValidError, 'unexpected_type')
      end
    end

    context 'when instantiated with  the username in the argument whose length is less than allowed' do
      let(:user_name) { random_str_by_range_length(0, standard_user_constraints[:min] - 1) }

      it 'exсeption "unexpected_length"' do
        expect { user }.to raise_error(described_class::DataValidError, 'unexpected_length')
      end
    end

    context 'when instantiated with a username in the argument whose length is longer than allowed' do
      let(:user_name) { random_str_by_range_length(standard_user_constraints[:max] + 1, 1000) }

      it 'exсeption "unexpected_length"' do
        expect { user }.to raise_error(described_class::DataValidError, 'unexpected_length')
      end
    end
  end
end
