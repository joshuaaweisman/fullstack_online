class WordChainer

    # initializers #############################################
    attr_reader :dictionary

    def initialize(dictionary_file_name)
        words = File.readlines("dictionary.txt").map(&:chomp)
        @dictionary = Set.new(words)
    end


    # instance methods #########################################
    def run(source, target)
        @current_words = [source]
        @all_seen_words = [source => nil]

        until @current_words.empty?
            new_current_words = Array.new
            explore_current_words(@current_words, new_current_words)

            new_current_words.each do |word| 
                print word + " " + @all_seen_words[word] + "//"
            end
            @current_words = new_current_words
        end
    end



    def explore_current_words(arr1, arr2)
        arr1.each do |word|
            adjacent_words(word).each do |adjacent_word|
                if !@all_seen_words.include?(adjacent_word)
                    arr2 << adjacent_word
                    @all_seen_words[adjacent_word] = word
                end
            end
        end
    end
    
    
    
    def adjacent_words(input_word)
        adjacents = []

        @dictionary.each do |dictionary_word| 
            if dictionary_word.length == input_word.length

                screwy_letters = 0
                dictionary_word.each_char.with_index do |char, idx|
                    screwy_letters += 1 if char != input_word[idx]
                end

                adjacents << dictionary_word if screwy_letters == 1
            end
        end

        adjacents
    end

end