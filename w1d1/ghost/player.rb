class Player
    # starters #######################################################
    attr_reader :name


    # initializers ###################################################
    def initialize(name)
        @name = name
    end


    # instance methods ###############################################
    def guess
        puts "Give me a letter: "
        letter = gets.chomp
        letter
    end

end