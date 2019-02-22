require_relative "game"
require_relative "player"


players = []


puts "How many people want to play?"
num_of_players = gets.chomp.to_i

num_of_players.times do 
    puts "What's the name of the next player?"
    players.push(Player.new(gets.chomp))
end


ghost = Game.new(players)
ghost.run