require 'pry'

class F
  attr_accessor :parent
  attr_reader :name, :size

  def initialize(name:, size:, parent: nil)
    @name = name
    @size = size
    @parent = parent
  end

  def to_s
    "#{name} (file size=#{size})"
  end
end

class D
  attr_accessor :parent
  attr_reader :name, :children

  def initialize(name:, parent: nil)
    @name = name
    @parent = parent
    @children = []
  end

  def root?
    @name == '/'
  end

  def parent
    root? ? self : @parent
  end

  def add_child(node)
    return if node.parent == self
    node.parent = self
    @children << node
  end

  def find_dir(name)
    @children.find { |c| c.is_a?(D) && c.name == name }
  end

  def find_file(name)
    @children.find { |c| c.is_a?(F) && c.name == name }
  end

  def to_s
    "#{name} (dir size=#{size})"
  end

  def size
    @size ||= @children.map(&:size).sum
  end
end

# input = File.read('sample.in')
input = File.read('input.in')

root = D.new(name: '/')
cwd = nil

input.each_line(chomp: true) do |line|
  parts = line.split

  if parts[0] == '$' # command
    if parts[1] == 'cd'
      case parts[2]
      when '/'
        cwd = root
      when '..'
        cwd = cwd.parent
      else
        cwd = cwd.find_dir(parts[2])
      end
    elsif parts[1] == 'ls'
      next
    end
  else # info
    if parts[0] == "dir"
      cwd.add_child(D.new(name: parts[1]))
    else
      cwd.add_child(F.new(name: parts[1], size: parts[0].to_i))
    end
  end
end

root.size # Call once to calculate sizes throughout entire tree.

def print_node(node, level = 0)
  if node.is_a?(D)
    puts "#{'  ' * level} - #{node}"
    node.children.each { |c| print_node(c, level + 1) }
  else
    puts "#{'  ' * level} - #{node}"
  end
end

# print_node(root)

def nodes_under_size(node, size)
  return [] if node.is_a?(F)
  matches = []
  matches << node if node.size <= size
  matches += node.children.flat_map { |c| nodes_under_size(c, size) }
end

puts "Part 1: #{nodes_under_size(root, 100_000).map(&:size).sum}"

TOTAL_SPACE = 70_000_000
WANTED_SPACE = 30_000_000

def nodes_gteq_size(node, size)
  return [] if node.is_a?(F)
  matches = []
  matches << node if node.size >= size
  matches += node.children.flat_map { |c| nodes_gteq_size(c, size) }
end

needed_space = root.size - (TOTAL_SPACE - WANTED_SPACE)
nodes = nodes_gteq_size(root, needed_space)

puts "Part 2: #{nodes.sort_by!(&:size).first.size}"
