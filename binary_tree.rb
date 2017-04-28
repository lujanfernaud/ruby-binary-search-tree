class Node
  attr_accessor :value, :parent, :left, :right

  def initialize(*args)
    @value  = args[:value]
    @parent = args[:parent]
    @left   = args[:left]
    @right  = args[:right]
  end
end
