require_relative 'tree_reader'
require_relative 'tree_finder'

tree_patterns = TreeReader.new.trees_from_file('trees.txt')

tree_count_1_1 = TreeFinder.new(tree_patterns, 1, 1).find_trees
tree_count_3_1 = TreeFinder.new(tree_patterns, 3, 1).find_trees
tree_count_5_1 = TreeFinder.new(tree_patterns, 5, 1).find_trees
tree_count_7_1 = TreeFinder.new(tree_patterns, 7, 1).find_trees
tree_count_1_2 = TreeFinder.new(tree_patterns, 1, 2).find_trees

puts tree_count_1_1
puts tree_count_3_1
puts tree_count_5_1
puts tree_count_7_1
puts tree_count_1_2

puts (tree_count_1_1 * tree_count_3_1 * tree_count_5_1 * tree_count_7_1 * tree_count_1_2)