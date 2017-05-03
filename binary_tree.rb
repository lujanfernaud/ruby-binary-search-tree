require "pry"

class Node
  attr_accessor :value, :parent, :left, :right

  def initialize(value = nil)
    @value  = value
    @parent = nil
    @left   = left
    @right  = right
  end

  def inspect
    "{v:#{value} l:#{left.inspect} | r:#{right.inspect}}"
  end
end

class Tree
  attr_accessor :root

  def initialize
    @root = Node.new
  end

  # Take an array of data and turn it into a binary tree.
  # Note: Currently assuming the array is sorted.
  def build(array, node = @root)
    return if array.size.zero?

    mid = array.size / 2
    node.value  = array[mid]
    left_array  = array[0...mid]
    right_array = array[mid + 1..-1]

    node.left  = Node.new(left_array.pop)
    node.right = Node.new(right_array.shift)
    node.left.parent  = node
    node.right.parent = node

    build(left_array, node.left)
    build(right_array, node.right)

    p @root
  end
end

data1 = [1, 2, 3, 4, 5, 6, 7, 8, 9]

tree1 = Tree.new

puts "\n-----------"
puts "Build tree:"
puts "#{data1}"
puts "-----------\n"
tree1.build(data1)
