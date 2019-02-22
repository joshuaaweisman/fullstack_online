def sum_to(n)
    return nil if n < 1
    return n if n == 1
    sum_to(n - 1) + n
end


def add_numbers(sum_array)
    return nil if sum_array.length < 1
    return sum_array[0] if sum_array.length == 1
    add_numbers(sum_array[1..-1]) + sum_array[0]
end


def gamma_fnc(n)
    return n if n == 1
    gamma_fnc(n - 1) * (n - 1)
end


def ice_cream_shop(flavors, favorite)
    return false if flavors.length == 0
    return true if flavors.last == favorite
    ice_cream_shop(flavors[0...-1], favorite) == favorite
end


def reverse(string)
    return "" if string.length == 0
    reverse(string[1..-1]) + string[0]
end