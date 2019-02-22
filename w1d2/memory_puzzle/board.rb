require_relative "card"

class Board
    attr_reader :grid



    def initialize(num_of_rows)
        @grid = Array.new
        @num_of_rows = num_of_rows
        populate
    end


    
    def populate
        # builds a randomly-shuffled "deck" of all the cards that will go on the board
        deck = Array.new
        total_pairs = (@num_of_rows ** 2) / 2
        total_cards = total_pairs * 2

        while deck.length < total_cards
            letter = ("A".."Z").to_a.sample
            card1, card2 = Card.new(letter), Card.new(letter)
            deck << card1 && deck << card2 unless deck.include?(card1)
        end
        deck.shuffle!

        # populates the main grid with unique rows of cards from the deck
        row_size = @num_of_rows
        until deck.empty?
            @grid << deck.shift(row_size)
        end
    end


    
    def [](position)
        row, column = position
        @grid[row][column]
    end



    def []=(position, value)
        row, column = position
        @grid[row][column] = value
    end


    
    # shows the board to the user
    def render
        system("clear")
        
        # prints the TOP ROW of numbers on the grid
        puts "  #{(0..@num_of_rows - 1).to_a.join(' ')}"

        # prints the SIDE ROW of numbers, and fills in the grid with cards
        @grid.each_with_index do |row, idx|
            values = row.map do |card| 
                if card.showing_face == true
                    card.value
                else
                    '•'
                end
            end
            puts "#{idx} #{values.join(' ')}"
        end
        sleep(2)
    end


    
    def flip_over_card(guessed_position)
        row, column = guessed_position
        if already_flipped?(guessed_position)
            puts "Hey dummy, you already flipped that one over."
        else
            @grid[row][column].show
            @grid[row][column].value
        end
    end



    def already_flipped?(position)
        row, column = position
        @grid[row][column].showing_face
    end



    def won?
        deck = []
        @grid.each do |row| 
            row.each { |card| deck << card }
        end
        deck.all? { |card| card.showing_face }
    end

end