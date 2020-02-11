# frozen_string_literal: true

require './lib/mastermind'
require './lib/codemaker'

describe Mastermind do
  before :each do
    codemaker = double('Codemaker', create_secret_code: nil, secret_code: %i[red blue green yellow])
    allow(CodeMaker).to receive(:new) { codemaker }
    @mastermind = Mastermind.new
  end

  context '#correct_guess?' do
    it 'returns true for correct guess' do
      expect(@mastermind.correct_guess?(%i[red blue green yellow])).to be true
    end

    it 'returns false for incorrect guess' do
      expect(@mastermind.correct_guess?(%i[red blue green green])).to be false
    end
  end

  context '#lost_game?' do
    it 'returns false when there are remaining turns' do
      expect(@mastermind.lost_game?).to be false
    end

    it 'returns true when the game is lost' do
      12.times do
        @mastermind.correct_guess?(%i[red blue green green])
      end
      expect(@mastermind.lost_game?).to be true
    end
  end

  context '#hint_pegs' do
    it 'returns no pegs when all colors are wrong' do
      expect(@mastermind.hint_pegs(%i[black black black black])).to eq([])
    end

    it 'returns white pegs when colors are in wrong spaces' do
      expect(@mastermind.hint_pegs(%i[yellow green blue red])).to eq(%i[white white white white])
    end

    it 'returns black pegs when all colors are correct' do
      expect(@mastermind.hint_pegs(%i[red blue green yellow])).to eq(%i[black black black black])
    end
  end
end
