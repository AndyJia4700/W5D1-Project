class HashSet
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !self.include?(key)
      self[key.hash] << key
      self.count += 1
    end
    resize! if self.count > num_buckets
    
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    unless !self.include?(key)
      self[key.hash].delete(key)
      self.count -= 1
    end
  end

  private

  def [](num)
    self.store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
  end
end
