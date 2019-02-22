require "byebug"

# warm-ups ##########################################
def range(min, max)
    return [] if min == max
    range(min, max - 1) << (max - 1)
end



def range_inclusive(min, max)
    return [1] if max == 1
    range(min, max - 1) << max
end



def sum(arr)
    return 0 if arr.length == 0 
    sum(arr[0...-1]) + arr[-1]
end



def sum_iterative(arr)
    sum = 0
    arr.each { |num| sum += num }
    sum
end



def palindrome?(str)
    return true if str[0] == str[-1]
    str[0] == str[-1] && palindrome?(str[1..-2])
end



# exponentiation ####################################
def exp(num, power)
    return 1 if power == 0
    return num if power == 1
    exp(num, power - 1) * num
end



def exp_again(base, power)
    return 1 if power == 0
    return base if power == 1

    half = exp_again(base, (power / 2))


    if power.even?
        half * half
    else
        base * half * half
    end
end



# deep dup ##########################################
def deep_dup_iterative(arr)
    new_arr = Array.new(arr.length) {[]}
    arr.each_with_index do |set, idx|
        set.each { |item| new_arr[idx] << item}
    end
    new_arr
end



def deep_dup_recursive(arr)
    final_array = []

    arr.each do |el|
        if el.is_a?(Array)
            final_array << deep_dup_recursive(el)
        else
            final_array << el
        end
    end

    final_array
end



# fibonacci #########################################
def fibonacci(n)
    return[0, 1].take(n) if n <= 2
    arr = fibonacci(n - 1)
    arr << arr[-1] + arr[-2]
end



def fibonacci_iterative(n)
    arr = [0, 1]
    
    while arr.length < n
        arr << arr[-1] + arr[-2]
    end
    arr
end



# binary search ######################################
def binary_search(arr, target_val)
    return nil if !arr.include?(target_val)
    center_idx = arr.length / 2
    center_val = arr[center_idx]

    if center_val == target_val
        return arr.index(center_val)
    elsif center_val < target_val
        right_arr = arr[center_idx + 1..-1]
        binary_search(right_arr, target_val) + center_idx + 1
    else
        left_arr = arr[0...center_idx]
        binary_search(left_arr, target_val)
    end
end




# subsets ##############################################
def array_subsets_iterative(arr)
    final = Array.new {[]}

    arr.each_with_index do |el1, idx1|
        final << el1

        arr.each_with_index do |el2, idx2|
            next if el1 == el2 || el1 > el2
            small_arr = arr[idx1..idx2]
            gap_arr = [arr[idx1], arr[idx2]]

            final << small_arr unless final.include?(small_arr)
            final << gap_arr unless final.include?(gap_arr)
            idx2 += 1
        end
    end

    final
end



class Array
    def subsets
        return [ [] ] if self.empty?

        target_num = self.last
        prev_arr = self[0..-2].subsets

        new_subset = prev_arr.map { |subset| subset + [target_num] }
        prev_arr + new_subset
    end
end



# permutations #########################################
def permutations(arr)
    return [arr, arr.rotate] if arr.length == 2

    final_arr = []
    
    arr.each_with_index do |num,index|
        anchor = num
        slice = arr.select { |el| el != arr[index] }
        permutations(slice).each do |combo|
        final_arr << [anchor] + combo
        end
    end

    final_arr
end



# merge sort ############################################
def merge_arrays(arr1, arr2)
    final_arr = []

    until arr1.empty? || arr2.empty?
        if arr1[0] > arr2[0]
            final_arr << arr2.shift     
        else
            final_arr << arr1.shift
        end
    end

    final_arr + arr1 + arr2

end



def merge_sort(arr)
    return arr if arr.length == 1

    split_idx = arr.length / 2
    side1 = merge_sort(arr[0...split_idx])
    side2 = merge_sort(arr[split_idx..-1])

    merge_arrays(side1, side2)
end



# make change ##########################################
def greedy_make_change(change_needed, coins)
    coin_pile = []
    current_coin = coins[0]
    multiplier = change_needed / current_coin

    if change_needed > current_coin
        multiplier.times { coin_pile << current_coin }
        change_needed -= current_coin * multiplier
        return coin_pile if change_needed == 0
    end

    coin_pile += greedy_make_change(change_needed, coins[1..-1])
    coin_pile.flatten
end



def make_best_change(change_needed, coins)
    debugger

    best_solution = nil
    return [] if change_needed == 0

    coins.each do |current_coin|
        coin_pile = []

        if change_needed > current_coin
            coin_pile << current_coin
            change_needed -= current_coin
            current_solution = coin_pile + make_best_change(change_needed, coins) 
            best_solution = current_solution if best_solution == nil || current_solution.count < best_solution_count        
        end
    end

    coin_pile += greedy_make_change(change_needed, coins[1..-1])
    coin_pile.flatten
    
    best_solution = nil
    current_solution = [coin] + make_best_change(change_needed, coins)
end