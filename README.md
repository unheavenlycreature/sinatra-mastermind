# Sinatra-Mastermind

[Mastermind](https://en.wikipedia.org/wiki/Mastermind_(board_game)) is a two player, code-breaking board game. This version of the game is implemented as a web app using [Sinatra](http://www.sinatrarb.com), as an [assignment](https://www.theodinproject.com/courses/ruby-on-rails/lessons/sinatra-project) from [The Odin Project](https://www.theodinproject.com). 

A command-line version of the game can be found [here](https://github.com/unheavenlycreature/Mastermind).

## Playing the game
The codemaker chooses an ordering of four colored *code pegs*, hidden from the codebreaker. The six possible colors are 

> `Red`, `Blue`, `Yellow`, `Green`, `White`, `Black`

The codebreaker proceeds to guess the ordering, placing four code pegs on the board. 

After each guess, the codemaker responds by placing up to four _key pegs_ on the board. The key pegs come in two variants:

>`Black` : Indicates one of the *code pegs* is ***both*** the correct color and in the correct position.
> 
>`White` : Indicates one of the *code pegs* is the correct color, but in the incorrect position.

Play continues for twelve turns. The game ends when the codebreaker guesses the correct code, or if all twelve turns pass without the codebreaker guessing correctly.