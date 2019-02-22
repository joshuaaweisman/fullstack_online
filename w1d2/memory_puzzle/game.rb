require_relative "board"
require_relative "card"
require "byebug"

class Game
    def initialize(grid_size)
        @board = Board.new(grid_size)
        @previous_guess = nil
    end



    def play
        while !@board.won?
            system("clear")
            @board.render
            puts "Go ahead, guess a position:"
            make_guess(gets.chomp.split(''))            
        end
    end



    def make_guess(position)
        row, column = position.map(&:to_i)
        current_guess = @board.grid[row][column]
        current_guess.show
        @board.render

        if @previous_guess == nil
            @previous_guess = current_guess
        else

            if compare_cards(@previous_guess, current_guess)
                @previous_guess, current_guess = nil, nil
            else
                @previous_guess.hide
                current_guess.hide
                @previous_guess, @current_guess = nil, nil
            end
        end
    end


    def valid_guess?(position)
        position.is_a?(Integer) && position.to_s.length == 2
    end



    def compare_cards(card_1, card_2)
        card_1.value == card_2.value
    end

end