struct Result
	match :: String
	beginIndex :: Int
	endIndex :: Int
end
function manacher_palindrome(D :: String) :: Vector{Result}
	if isempty(D)
		return []
	end

	v = D
	D = [Int(c) for c in v] # character to number

	results :: Vector{Result} = []
	n = length(D)
	M = zeros(Int, n-1)

	enp = 1; pal = 0; bp = -1; count = -1; mdp = -1
	finish = false; reset = false
	minimumSizeAllow = 2

	while true
		if !reset
			enp +=1
			if enp == n + 1
				break
			end
			mdp = bp = enp - 1
			count = 0
		end

		reset = false
		while D[enp] == D[bp]
			count +=1
			enp += 1
			bp -= 1
			if bp <= 1
				count +=1
				pal = enp
				break
			end
			if enp == n + 1
				finish = true
				break
			end
		end
		if count > minimumSizeAllow
			M[mdp] = count
		end

		if finish
			break
		end

		for f = 1 : count
			if mdp == f
				break
			end
			if M[mdp - f] != count - f
				M[mdp + f] = min(count - f, M[mdp - f])
			else
				mdp = mdp + f
				count = count - f
				bp = mdp - count
				reset = true
				break
			end
		end
	end

	# pos processing
	for i = 2 : length(M) - 1
		if M[i] == 0
			continue
		end
		push!(results, Result(v[i-M[i]+1:i+M[i]], i-M[i], i+M[i]))
	end

	return results
end

data = "123321623001900911189"
for result in manacher_palindrome(data)
	println(result)
end
