require 'command_input'

RSpec.describe CommandInput do
  context '#from_text' do
    subject(:command_input) { described_class.from_text(text) }

    context 'without text' do
      let(:text) { nil }

      it 'sets instruction to help' do
        expect(command_input.instruction).to eq('help')
      end

      it 'sets details to nil' do
        expect(command_input.details).to eq(nil)
      end
    end

    context 'with empty text' do
      let(:text) { '' }

      it 'sets instruction to help' do
        expect(command_input.instruction).to eq('help')
      end

      it 'sets details to nil' do
        expect(command_input.details).to eq(nil)
      end
    end

    context 'with one-word text' do
      let(:text) { 'instruction' }

      it "sets instruction to 'instruction'" do
        expect(command_input.instruction).to eq('instruction')
      end

      it 'sets details to nil' do
        expect(command_input.details).to eq(nil)
      end
    end

    context 'with two-word text' do
      let(:text) { 'instruction details' }

      it "sets instruction to 'instruction'" do
        expect(command_input.instruction).to eq('instruction')
      end

      it "sets details to 'details'" do
        expect(command_input.details).to eq('details')
      end

      context 'with additional whitespace' do
        let(:text) { '     instruction     details    ' }

        it "sets instruction to 'instruction'" do
          expect(command_input.instruction).to eq('instruction')
        end

        it "sets details to 'details'" do
          expect(command_input.details).to eq('details')
        end
      end
    end

    context 'with text containing more than 2 words' do
      let(:text) { 'instruction details with even more details' }

      it "sets instruction to 'instruction'" do
        expect(command_input.instruction).to eq('instruction')
      end

      it "sets details to 'details'" do
        expect(command_input.details).to eq('details with even more details')
      end
    end
  end
end
