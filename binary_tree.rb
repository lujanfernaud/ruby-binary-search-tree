require "pry"

class Node
  attr_accessor :value, :parent, :left, :right

  def initialize(value = nil)
    @value = value
  end

  def insert(value)
    return if @value == value

    case @value <=> value
    when  1 then insert_left(value)
    when -1 then insert_right(value)
    end
  end

  def breadth_first_search(value)
    return self if @value == value

    queue = []
    queue << @left  if @left
    queue << @right if @right

    until queue.empty?
      node = queue.shift
      return node if node.value == value

      queue << node.left if node.left
      queue << node.right if node.right
    end
  end

  def depth_first_search(value)
    return self if @value == value

    stack   = [self]
    visited = []

    until stack.empty?
      node = stack.pop
      return node if node.value == value
      visited << node

      stack << if node.left && !visited.include?(node.left)
                 node.left
               elsif node.right && !visited.include?(node.right)
                 node.right
               else
                 node.parent
               end
    end
  end

  def dfs_recursive(value, node)
    return node if node.value == value

    if value < node.value && node.left
      dfs_recursive(value, node.left)
    elsif value > node.value && node.right
      dfs_recursive(value, node.right)
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
  attr_accessor :root

  def initialize
    @root = Node.new
  end

  def build(array)
    if array == array.sort
      build_from_sorted(array.uniq)
    else
      build_from_unsorted(array)
    end
  end

  def breadth_first_search(value)
    @root.breadth_first_search(value)
  end

  def depth_first_search(value)
    @root.depth_first_search(value)
  end

  def dfs_recursive(value)
    @root.dfs_recursive(value, @root)
  end

  private

  def build_from_sorted(array, node = @root)
    return if array.empty?

    mid = array.size / 2
    node.value  = array[mid]
    left_array  = array[0...mid]
    right_array = array[mid + 1..-1]

    build_left(left_array, node)
    build_right(right_array, node)

    @root
  end

  def build_left(array, node)
    return if array.empty?

    node.left = Node.new(array[array.size / 2])
    node.left.parent = node
    build_from_sorted(array, node.left)
  end

  def build_right(array, node)
    return if array.empty?

    node.right = Node.new(array[array.size / 2])
    node.right.parent = node
    build_from_sorted(array, node.right)
  end

  def build_from_unsorted(array)
    @root.value = array.shift
    array.each { |n| @root.insert(n) }
    @root
  end
end

data1 = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
data2 = [86, 32, 20, 18, 90, 52, 37, 66, 88, 26, 58, 94, 5, 54, 15, 89, 90, 34]

tree1 = Tree.new
tree2 = Tree.new

puts "\n---------------------"
puts "Build tree (unsorted)"
puts "---------------------\n"
puts "Array: #{data1}\n\n"
p tree1.build(data1)

puts "\n-------------------"
puts "Build tree (sorted)"
puts "-------------------\n"
puts "Array: #{data1.sort}\n\n"
p tree1.build(data1.sort)

puts "\n--------------------------------------"
puts "Breadth First Search (adding to queue)"
puts "--------------------------------------\n"
value = data1.sample
puts "Value to find: #{value}\n\n"
p tree1.breadth_first_search(value)

puts "\n------------------------------------"
puts "Depth First Search (adding to queue)"
puts "------------------------------------\n"
value = data1.sample
puts "Value to find: #{value}\n\n"
p tree1.depth_first_search(value)

puts "\n------------------------------"
puts "Depth First Search (recursive)"
puts "------------------------------\n"
value = data1.sample
puts "Value to find: #{value}\n\n"
p tree1.dfs_recursive(value)

puts "\n-----------------"
puts "Build bigger tree"
puts "-----------------\n"
puts "Array: #{data2}\n\n"
p tree2.build(data2)

puts "\n------------------------------"
puts "Depth First Search (recursive)"
puts "------------------------------\n"
value = data2.sample
puts "Value to find: #{value}\n\n"
p tree2.dfs_recursive(value)
