require "pry"

class Node
  attr_accessor :value, :parent, :left, :right

  def initialize(args = default)
    @value  = args[:value]
    @parent = args[:parent]
    @left   = args[:left]
    @right  = args[:right]
  end

  def default
    { value: nil, parent: nil, left: nil, right: nil }
  end

  def insert(value)
    return false if value == self.value

    if value > self.value

      if right.nil?
        puts "Adding #{value} to the right of #{self.value}"
        self.right = Node.new(value: value)
      else
        right.insert(value)
      end

    elsif value < self.value

      if left.nil?
        puts "Adding #{value} to the left of #{self.value}"
        self.left = Node.new(value: value)
      else
        left.insert(value)
      end

    end
  end
end

class Tree
  attr_accessor :root

  def initialize
    @root = Node.new
  end

  def build(array)
    @root.value = array[(array.length / 2).round]
    puts "Root value: #{@root.value}"

    array.each do |value|
      @root.insert(value)
    end
  end
end

data = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

tree = Tree.new
tree.build(data)
