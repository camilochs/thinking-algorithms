function get_value(C :: String, index :: Int)
    C[nextind(C, index)]
end

function get_partial(C :: String, start :: Int, finish :: Int)
    C[nextind(C, start) : nextind(C, finish)]
end

struct Result
    shift :: Int
    found :: Bool
end

function karp_rabin_matcher(T :: String, P :: String, b :: Int, q :: Int)
    #q = prime number
    #b = base
    n :: Int = length(T)
    m :: Int = length(P)
    if m > n
        return Result(-1, false)
    end

    d :: Int = b^(m-1) % q
    h_y :: Int = 0
    h_x :: Int = 0

    #preprocessing
    for i = 1 : m
        h_y += (Int(get_value(T, i - 1)) * (b^(m - i )))
        h_x += (Int(get_value(P, i - 1)) * (b^(m - i )))
    end

    h_y = h_y % q
    h_x = h_x % q

    for i = 0 : n - m
        if h_y == h_x
            if P == get_partial(T, i, i + m - 1)
                println("Pattern found:" , i)
                return Result(i, true)
            end
        else
            h_y = (h_y + b * q - Int(get_value(T, i)) * d) % q
            h_y = (h_y * b + Int(get_value(T, i + m))) % q
            i += 1
        end
    end
end

result = karp_rabin_matcher("hola quora!!", "quora", 256, 8355967)
println(result)
