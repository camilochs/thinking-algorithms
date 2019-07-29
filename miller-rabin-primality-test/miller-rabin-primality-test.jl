function miller_rabin_primality_test(n, k = 40)

	if n % 2 == 0
		return false
	end
	if n == 2
		return true
	end

    m = n - 1
	r = 0
	while m % 2 == 0
		r += 1
		m = Int(m / 2)
	end

	for i = 1 : k - 1
		a = first(rand(2 : n - 1, 1))
		b = (a^m) % n
		if b == 1 || b == n - 1
			continue
		end
		check = false
		for i = 1 : r - 1
			b = (b^2) % n
			if b == n - 1
				check = true
				break
			end
		end
		if check
			return false
		end

	end
	return true
end

result = miller_rabin_primality_test(318)
println(result)
