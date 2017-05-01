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

  def breadth_first_search(value)
    return self if self.value == value

    queue = []
    queue << left if left
    puts "Adding #{left.value}" if left
    queue << right if right
    puts "Adding #{right.value}" if right

    queue.each do |node|
      queue << node.left if node.left
      puts "Adding #{node.left.value}" if node.left
      queue << node.right if node.right
      puts "Adding #{node.right.value}" if node.right
    end

    queue.select { |node| node.value == value ? node : nil }.shift
  end

  def depth_first_search(root, value)
    return self if self.value == value

    queue = []
    queue << root

    queue.each do |node|
      if node.left
        queue << node.left
        puts "Adding #{node.left.value}"
      elsif node.right
        queue << node.right
        puts "Adding #{node.right.value}"
      elsif queue[-2].right == node
        puts "Jumping back and adding #{queue[-3].right.value}"
        queue << queue[-3].right
      elsif queue[-2].right
        puts "Jumping back and adding #{queue[-2].right.value}"
        queue << queue[-2].right
      end
    end

    queue.select { |node| node.value == value ? node : nil }.shift
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

  def breadth_first_search(value)
    @root.breadth_first_search(value) unless @root.value.nil?
  end

  def depth_first_search(value)
    @root.depth_first_search(self.root, value) unless @root.value.nil?
  end
end

data = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

tree = Tree.new

puts "\n----------"
puts "Build tree"
puts "----------\n"
tree.build(data)

puts "\n--------------------------------------"
puts "Breadth First Search (adding to queue)"
puts "--------------------------------------\n"
p tree.breadth_first_search(67)

puts "\n----------------------------------"
puts "Depth First Search (adding to queue)"
puts "----------------------------------\n"
p tree.depth_first_search(67)
