class TreeFinder
  TREE = '#'

  def initialize(tree_patterns, right, down)
    @tree_patterns = tree_patterns
    @right = right
    @down = down
  end

  def find_trees
    position = 0
    tree_count = 0
    @tree_patterns.each_with_index do |pattern, index|
      if matches_down(index)
        if pattern[position] == TREE
          tree_count += 1
        end
        position = (position + @right) % pattern.length
      end
    end
    tree_count
  end

  private

  def matches_down(index)
    index % @down == 0
  end
end