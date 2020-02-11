# frozen_string_literal: true

require_relative 'codemaker'

# A game manager for the board game "Mastermind"
class Mastermind
  def initialize
    @codemaker = RobotCodeMaker.new
    @remaining_turns = 12
  end

  def new_game
    @remaining_turns = 12
    @codemaker.create_secret_code
  end

  def correct_guess?(guess)
    @remaining_turns -= 1
    guess == @codemaker.secret_code
  end

  def lost_game?
    @remaining_turns.zero?
  end

  def hint_pegs(guesses)
    secret_code = @codemaker.secret_code.clone
    guess = guesses.clone
    hints, remaining = add_perfect_matches(secret_code, guess)
    hints = add_color_matches(secret_code, remaining, hints)
    hints.shuffle
  end

  private

  def add_perfect_matches(secret_code, guess)
    hints = []
    remaining = Hash.new(0)
    until guess.empty?
      secret_code_peg = secret_code.shift
      guess_peg = guess.shift
      if secret_code_peg == guess_peg
        hints << :black
      else
        secret_code << secret_code_peg
        remaining[guess_peg] += 1
      end
    end
    [hints, remaining]
  end

  def add_color_matches(secret_code, remaining, hints)
    secret_code.each do |peg|
      if remaining[peg].positive?
        hints << :white
        remaining[peg] -= 1
      end
    end
    hints
  end
end
