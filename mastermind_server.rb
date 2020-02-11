# frozen_string_literal: true

require 'sinatra'
require './lib/mastermind'
enable :sessions

mastermind = Mastermind.new

get '/' do
  @message = message if won_or_lost?
  init_game(mastermind) if params[:turn].nil? || won_or_lost?
  @session = session
  erb :index
end

post '/guess' do
  guesses = unpack_guesses(params).map(&:to_sym)
  if mastermind.correct_guess?(guesses)
    session[:game_status] = 'win'
  elsif mastermind.lost_game?
    session[:game_status] = 'lose'
  end
  update_session(session, guesses + mastermind.hint_pegs(guesses))
  redirect "/?turn=#{session[:turn]}"
end

def css_color(color)
  colors = {
    red: '#f74545',
    blue: '#5d5bff',
    yellow: '#f7ca66',
    green: '#4caf50',
    white: 'antiquewhite',
    black: 'black'
  }
  colors[color]
end

def unpack_guesses(params)
  [params[:f], params[:s], params[:t], params[:fo]]
end

def update_session(session, pegs)
  turn = session[:turn]
  session["colors_#{turn}"] = pegs.map { |peg| css_color(peg) }
  session[:turn] += 1
end

def init_game(mastermind)
  mastermind.new_game
  session[:turn] = 0
  session[:game_status] = nil
  12.times do |turn|
    session["colors_#{turn}"] = nil
  end
end

def won_or_lost?
  !session[:game_status].nil?
end

def message
  if session[:game_status] == 'win'
    return 'Congrats, you win! Starting a new game.'
  end

  'Sorry, you lose! Starting a new game.'
end
