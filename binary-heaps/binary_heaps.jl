mutable struct Heap
  data :: Vector{Int}
  size :: Int
	Heap() = new(zeros(Int, 2), 0)
end

function printHeap(h :: Heap)
  println(h.data[1:h.size])
end

function resize(h :: Heap)
  resize!(h.data, length(h.data) * 2)
end

function deleteMin(h :: Heap)
  if h.size == 0
    return []
  end
  h.data[1], h.data[h.size] = h.data[h.size], h.data[1] # swap
  h.data[h.size] = -1
  h.size -= 1

  value = h.data[1]
  pos = 1
  while pos < h.size - 1
    pivot = pos * 2
    if h.data[pivot] <= value
      h.data[pos], h.data[pivot] = h.data[pivot], h.data[pos] # swap
      pos = pivot
    else
      break
    end
  end
end
function insert(h :: Heap, value :: Int)
  if h.size == length(h.data) - 1
    resize(h)
  end
  h.size += 1
  pos = h.size

  h.data[pos] = value
  while pos > 1
    pivot = Int(floor(pos / 2))
    if h.data[pivot] >= value
      h.data[pos], h.data[pivot] = h.data[pivot], h.data[pos] # swap
      pos = pivot
    else
      break
    end
  end
end


heap = Heap()
insert(heap, 5)
printHeap(heap)

insert(heap, 10)
printHeap(heap)

insert(heap, 15)
printHeap(heap)

insert(heap, 20)
printHeap(heap)

insert(heap, 11)
printHeap(heap)

insert(heap, 1)
printHeap(heap)

deleteMin(heap)
printHeap(heap)

deleteMin(heap)
printHeap(heap)

deleteMin(heap)
printHeap(heap)

deleteMin(heap)
printHeap(heap)

deleteMin(heap)
printHeap(heap)
