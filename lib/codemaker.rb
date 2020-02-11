# frozen_string_literal: true

# Base class for all CodeMakers.
class CodeMaker
  VALID_COLORS = %i[red blue yellow green white black].freeze

  def initialize; end
end

# An AI that can play the role of CodeMaker.
class RobotCodeMaker < CodeMaker
  attr_reader :secret_code
  def initialize
    super
  end

  def create_secret_code
    @secret_code = []
    4.times do
      @secret_code << VALID_COLORS[rand(6)]
    end
  end
end
