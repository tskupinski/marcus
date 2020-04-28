require 'marcus_commands/help'
require 'printer'

RSpec.describe MarcusCommands::Help do
  let(:printer) { Printer.new }
  it 'prints the help' do
    expect(printer).to receive(:help)
    described_class.new(nil, nil, nil, nil, printer).execute
  end
end
