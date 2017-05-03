require "pry"

module SortChecker
  refine Array do
    def sorted?
      self == self.sort
    end
  end
end

class Node
  attr_accessor :value, :parent, :left, :right

  def initialize(value = nil)
    @value  = value
    @parent = nil
    @left   = left
    @right  = right
  end

  def insert(value)
    return if @value == value

    case @value <=> value
    when  1 then insert_left(value)
    when -1 then insert_right(value)
    end
  end

  def inspect
    "{#{value} #{value}L:#{left.inspect} | #{value}R:#{right.inspect}}"
  end

  private

  def insert_left(value)
    return @left.insert(value) unless left.nil?

    @left = Node.new(value)
    @left.parent = self
  end

  def insert_right(value)
    return @right.insert(value) unless right.nil?

    @right = Node.new(value)
    @right.parent = self
  end
end

class Tree
  using SortChecker

  attr_accessor :root

  def initialize
    @root = Node.new
  end

  # Take an array of data and turn it into a binary tree.
  def build(array)
    array.sorted? ? build_from_sorted(array) : build_from_unsorted(array)
  end

  def build_from_sorted(array, node = @root)
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

    @root
  end

  def build_from_unsorted(array)
    @root.value = array.shift
    array.each { |n| @root.insert(n) }

    @root
  end
end

data1 = [1, 2, 3, 4, 5, 6, 7, 8, 9].shuffle

tree1 = Tree.new

puts "\n-----------"
puts "Build tree:"
puts "#{data1}"
puts "-----------\n"
p tree1.build(data1)
