

function best_fit(blockSize :: Array{Int, 1},
				  processSize :: Array{Int, 1})

	n = length(blockSize)
	m = length(processSize)
	active = fill(false, length(blockSize))

	for j = 1 : m
		index_found = -1
		best = typemax(Int)
		for i = 1 : n
			if active[i]
				continue
			end
			diff = blockSize[i] - processSize[j]
			if diff > 0 && best > diff
				best = diff
				index_found = i
			end
		end
		if index_found != -1
			active[index_found] = true
			println("Process Size: ", processSize[j],
					" Block Size: ", blockSize[index_found])
		end
	end
end
best_fit([100, 450, 200, 300, 600], [212, 417, 112, 426])
