class Vertex
  attr_accessor :value, :weight, :previous, :adjacent_vertices, :possible_moves
  def initialize(value)
    @value = value
    @adjacent_vertices = []
    @weight = Float::INFINITY
    @previous = nil
    @possible_moves = []
  end
end

class Graph
  attr_accessor :vertices, :adjacent_vertices, :possible_moves, :dijkstra_source

  def initialize
    @vertices = []
    @dijkstra_source = nil
  end

  def add_vertex(value)
    @vertices << Vertex.new(value)
  end

  def count
    @vertices.length
  end

  def add_edge(start_value, end_value, weight = nil, undirected = true)
    from = vertices.index { |v| v.value == start_value }
    to   = vertices.index { |v| v.value == end_value }
    vertices[from].adjacent_vertices[to] = true
    vertices[from].weights[to] = weight if weight
    if undirected
      vertices[to].adjacent_vertices[from] = true
      vertices[to].weights[from] = weight if weight
    end
  end
  
  def find_vertex_by_name(name)
    vertices.each do |v|
      return v if v.value == name
    end
    nil
  end

  def generate_chess_board(size)
    generate_vertices(size)
    generate_edges
  end

  def generate_vertices(size)
    size.times do |x|
      size.times do |y|
        self.add_vertex([x,y])
      end
    end
  end

  def generate_edges
    moveset = [[-1,-2],[-1,2],[-2,-1],[-2,1],[1,-2],[1,2],[2,-1],[2,1]]
    vertices.each do |vertex|
      moveset.each do |move|
        x = vertex.value[0] + move[0]
        y = vertex.value[1] + move[1]
        if (0..7).include?(x) && (0..7).include?(y)
          new_vertex = [x,y]
          unless vertex.adjacent_vertices.include?(new_vertex)
          self.add_edge(vertex.value, new_vertex)
          vertices.each do |v|
            vertex.possible_moves << v if v.value == new_vertex
          end
          end
        end
      end
    end
  end
end

graph = Graph.new
graph.generate_chess_board(8)

def dijkstra(graph, source)
  return if graph.dijkstra_source == source
  source = graph.find_vertex_by_name(source)
  unvisited = graph.vertices.map {|v| v}
  graph.vertices.each do |vertex| 
    vertex.weight = Float::INFINITY
    vertex.previous = nil
  end
  source.weight = 0
  until unvisited.empty?
    current_node = unvisited.min_by(&:weight)
    break if current_node.weight == Float::INFINITY
    unvisited.delete(current_node)
    current_node.possible_moves.each do |v|
      possible_move = graph.find_vertex_by_name(v.value)
      if unvisited.include?(possible_move)
        alt = current_node.weight + 1 
        if alt < possible_move.weight
          possible_move.weight = alt
          possible_move.previous = current_node
        end
      end
    end
  end
  graph.dijkstra_source = source
end

def find_shortest_path(graph, source, target)
  dijkstra(graph, source)
  path = []
  u = target
  while u
    path.unshift(u)
    u = (graph.find_vertex_by_name(u).previous.value if graph.find_vertex_by_name(u).previous)
  end
  return path
end

print find_shortest_path(graph, [3,3], [4,3])
