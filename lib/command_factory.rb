require_relative './marcus_commands/list'
require_relative './marcus_commands/not_found'
require_relative './marcus_commands/select'
require_relative './marcus_commands/abort'

class CommandFactory
  COMMANDS = {
    list: MarcusCommands::List,
    select: MarcusCommands::Select,
    abort: MarcusCommands::Abort
  }.freeze

  def self.build(command_input, machine, inventory, treasury)
    COMMANDS.fetch(
      command_input.instruction&.to_sym, MarcusCommands::NotFound
    ).new(command_input.details, machine, inventory, treasury)
  end
end
