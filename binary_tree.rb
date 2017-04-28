class Node
  attr_accessor :value, :parent, :children

  def initialize(*args)
    @value    = args[:value]
    @parent   = args[:parent]
    @children = args[:children]
  end
end
