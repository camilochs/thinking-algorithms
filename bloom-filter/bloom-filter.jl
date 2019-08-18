mutable struct BloomFilter
  n :: Int
  size :: Int
  data :: Array{Int, 1}
  k :: Int
  hash_random_value :: Array{Int, 1}
  hash :: Function
  BloomFilter(s, total_hash_func, h) = new(0, s, zeros(Int, s), total_hash_func, rand(1:99999, total_hash_func), h)
end

function hash_value(x, r, size, p)
   (((r * x) % p) % size) + 1
end

function insert(bloom, v)
   hash_values = [bloom.hash(v, r, bloom.size, 8355967) for r in bloom.hash_random_value]
   for set in hash_values
      bloom.data[set] = 1
   end
   bloom.n += 1
   println(hash_values)
   println(bloom.data)
end

function exists(bloom, v)
   hash_values = [bloom.hash(v, r, bloom.size, 8355967) for r in bloom.hash_random_value]
   println(hash_values)
   for set in hash_values
      println(bloom.data[set])
      if bloom.data[set] == 0
         return false, (1 - 1 / bloom.size) ^ (bloom.k * bloom.n)
      end
   end
   return true, 100.0
end

bloom = BloomFilter(100, 2, hash_value)

insert(bloom, 23)
insert(bloom, 44)
insert(bloom, 48)
exists(bloom, 312)
insert(bloom, 482)
exists(bloom, 12)
insert(bloom, 312)
exists(bloom, 32)
insert(bloom, 408)
exists(bloom, 440)
