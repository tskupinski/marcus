class CommandInput
  def initialize(instruction, details)
    @instruction = set_instruction(instruction)
    @details = details
  end

  attr_reader :instruction, :details

  def self.from_text(text)
    instruction, details = text&.strip&.split(' ', 2)

    new(instruction, details)
  end

  private

  def set_instruction(instruction)
    instruction || 'help'
  end
end
