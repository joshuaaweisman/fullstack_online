require_relative "board"

class Card
    attr_reader :value, :showing_face
    
    def initialize(value, showing_face = false)
        @value = value.to_s
        @showing_face = showing_face
    end


    def hide
        @showing_face = false
    end


    def show
        @showing_face = true
    end


    def ==(other_card)
        other_card.class == self.class && other_card.value == self.value
    end
end

