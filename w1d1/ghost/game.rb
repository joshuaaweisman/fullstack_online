require_relative "player"
require "set"

class Game
    # starters #######################################################
    attr_reader :players, :fragment, :dictionary, :scoreboard


    # class variables ################################################
    ALPHABET = Set.new('abcdefghijklmnopqrstuvwxyz'.chars)


    # initializers ###################################################
    def initialize(players)
        @players = players
        @fragment = ""
        words = File.readlines("dictionary.txt").map(&:chomp)
        @dictionary = Set.new(words)
        @scoreboard = Hash.new { |scoreboard, player| scoreboard[player] = 0}
    end


    # instance methods ###############################################
    def run
        until game_over?
            play_new_round
            puts "-----"
            puts "-----"
            puts "Ahhh. #{@fragment.capitalize} is a full word!"
            puts "#{previous_player.name} lost that round."
            display_scores
            puts "-----"
            puts "-----"
        end
        declare_winner
    end


    def current_player
        @players[0]
    end


    def previous_player
        @players.last
    end


    def next_player!
        @players.rotate!
    end


    def play_new_round
        @fragment = ""

        until round_over?
            take_turn(current_player)
            next_player!
        end
    end


    def take_turn(player)
        puts "It's #{player.name}'s turn!"
        letter = player.guess

        until valid_play?(letter)
            invalid_move_alert(player)
            letter = player.guess
        end

        update_fragment(letter)

        if is_word?(@fragment)
            @scoreboard[player] += 1
        end
    end


    def valid_play?(string)
        return false if !ALPHABET.include?(string)

        potential_fragment = @fragment + string   
        dictionary.any? { |word| word.start_with?(potential_fragment) }
    end


    def invalid_move_alert(player)
        puts "Come on, #{player.name}, that shit ain't gonna work. Try again."
    end


    def is_word?(fragment)
        @dictionary.include?(fragment)
    end


    def update_fragment(letter)
        @fragment += letter
    end


    def display_scores
        names = @scoreboard.keys.map { |player| player.name }
        scores = @scoreboard.values

        puts "SCORE"
        names.each_with_index do |name, idx|
            score_so_far = scores[idx]
            puts "#{name}: #{score_translated(score_so_far)}"
        end
    end


    def score_translated(num)
        "GHOST"[0...num]
    end


    def round_over?
        is_word?(@fragment)
    end


    def game_over?
        @scoreboard.each do |player, score|
            return true if @scoreboard[player] >= 5
        end
        false
    end


    def declare_winner
        @scoreboard.each do |player, score|
            if @scoreboard[player] == 5
                puts "Awwww shit, #{player.name} is the loser!"
            end
        end
    end
    #
end