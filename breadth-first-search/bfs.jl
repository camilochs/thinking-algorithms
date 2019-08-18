
using DataStructures

function bfs(E :: Dict{Int, Array{Int,1}}, start, x)
	dist = 0
	if !haskey(E, start)
		return false, dist
	end

	visited = Dict()
	G = Queue{Int}()
	enqueue!(G, start)
	while !isempty(G)
		v = dequeue!(G)
		dist += 1
		for e in E[first(v)]
			if haskey(visited, (v, e)) || haskey(visited, (e, v))
				continue
			end
			println((v, e))
			if e == x
				return true, dist
			end
			enqueue!(G, e)
			visited[(v, e)] = true
		end
	end
	return false, dist

end



graph = [(1,2), (2,3), (2,4), (2,5), (5, 6), (6, 7), (4,7), (7, 9), (9, 10)]
x = 10

E = Dict{Int, Array{Int,1}}()
for pair in graph
	if !haskey(E, last(pair))
		E[last(pair)] = []
	end
	if !haskey(E, first(pair))
		E[first(pair)] = []
	end
	push!(E[first(pair)], last(pair))
	push!(E[last(pair)], first(pair))
end

print(E)
result = bfs(E, 1, 4)
print(result)
