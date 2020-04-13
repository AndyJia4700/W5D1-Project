class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = Array.new(max){false}
  end

  def insert(num)
    raise "Out of bounds" if num < 0 || num > @store.length - 1
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] 
  end

  private

  def is_valid?(num)
    # num < 0 || num > @store.length - 1
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    self.store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !self.include?(num)
      self[num] << num
      @count += 1
    end
    resize! if self.count > num_buckets
  end

  def remove(num)
    unless !self.include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
   self.store[num % (num_buckets)]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    self.store.length
  end

  def resize!
    old_store = self.store
    @count = 0
    @store = Array.new(num_buckets * 2) {Array.new}
    old_store.flatten.each {|num|insert(num)}
  end

end
