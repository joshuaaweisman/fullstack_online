class Array

    # runs the given block on each element of the array
    def my_each(&prc)
        idx = 0
        while idx < self.length
            current_el = self[idx]
            prc.call(current_el)
            
            idx += 1
        end

        self
    end


    # returns an array containing only the elements that DO satisfy the given block
    def my_select(&prc)
        arr = []
        self.my_each { |el| arr << el if prc.call(el) }
        arr
    end



    # returns an array containing only elements that DON'T satisfy the given block
    def my_reject(&prc)
        arr = []
        self.my_each { |el| arr << el if !prc.call(el) }
        arr
    end



    # returns true if ANY element of the array satisfies the given block
    def my_any?(&prc)
        self.my_each { |el| return true if prc.call(el) }
        false
    end



    # returns true if ALL elements of the array satisfy the given block
    def my_all?(&prc)
        self.my_each { |el| return false if !prc.call(el) }
        true
    end



    # transforms the array into a one-dimensional array
    def my_flatten(final_arr = [])     
        self.my_each do |el|
            debugger
            if el.class == Integer
                final_arr << el
            else
                el.my_flatten(final_arr)
            end
        end
        result
    end



    # returns a new array, where the elements from all the *given_arrays are "zipped" together
    def my_zip(*given_arrays)
        result = []

        self.each_with_index do |el, idx|
            internal_array = [el]
            given_arrays.each { |given_array| internal_array << given_array[idx] }
            result << internal_array
        end

        result
    end



    # returns a new array with the elements rotated 'turns' number of times
    def my_rotate(turns = 1)
        arr = self.map { |el| el }

        if turns > 0
            turns.times do
                target_element = arr.shift
                arr << target_element
            end
        elsif turns < 0
            turns.abs.times do
                target_element = arr.pop
                arr.unshift(target_element)
            end
        end

        arr
    end



    # joins all the characters of an array into a single string, separated by 'spacer'
    def my_join(spacer = '')
        str = ''

        self.each_with_index do |char, idx|
            str += char
            str += spacer if idx != self.length - 1
        end

        str
    end



    # returns a new array with all the elements of the original array reversed
    def my_reverse
        arr = []

        idx = self.length - 1
        while idx >= 0
            arr << self[idx]
            idx -= 1
        end

        arr
    end



    # sorts an array of integers from small to large. DOES NOT modify original array
    def bubble_sort(&prc)
        arr = self.dup
        sorted = false

        while !sorted
            sorted = true

            (0...self.length - 1).each do |idx1|
                num1, num2 = arr[idx1], arr[idx1 + 1]

                if prc.call(num1, num2) == 1
                    arr[idx1], arr[idx1 + 1] = num2, num1
                    sorted = false
                end
            end
        end
    
        arr
      end



      # sorts an array of integers from small to large. DOES modify the original array
      def bubble_sort!(&prc)
        sorted = false

        while !sorted
            sorted = true

            (0...self.length - 1).each do |idx1|
                num1, num2 = self[idx1], self[idx1 + 1]

                if prc.call(num1, num2) == 1
                    self[idx1], self[idx1 + 1] = num2, num1
                    sorted = false
                end
            end
        end

        self
      end

end



# returns an array containing all the substrings of the original string
def substrings(string)
    arr = []
    string.each_char.with_index do |char1, idx1|
        arr << char1
      
        idx2 = idx1 + 1
        while idx2 < string.length
            arr << string[idx1..idx2]
  
            idx2 += 1
        end
    
    end

    arr
end



# returns an array containing all the substrings of the original string THAT ARE WORDS
def subwords(word, dictionary)
    arr = substrings(word)
    arr.select { |str| dictionary.include?(str) }
end