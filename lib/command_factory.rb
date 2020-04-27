require_relative './marcus_commands/list'
require_relative './marcus_commands/not_found'

class CommandFactory
  COMMANDS = {
    list: MarcusCommands::List
  }.freeze

  def self.build(command_input, machine, inventory, treasury)
    COMMANDS.fetch(
      command_input.instruction&.to_sym, MarcusCommands::NotFound
    ).new(command_input.details, machine, inventory, treasury)
  end
end
