Knights Travails


## Description

Task is to build a function that shows the simplest possible way to get from one square to another by outputting all squares the knight will stop on along the way. Think of the board as having 2-dimensional coordinates. I used the graph data structure to represent the board as a graph where each cell (graph vertex) is connected to the possible moves. I used [Dijkstra's algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm) to find the shortest path between the given source and the destination.

## Example

```ruby
find_shortest_path(graph, [3,3], [4,3])

# Output what that full path looks like
[[3, 3], [1, 4], [2, 2], [4, 3]]
```

## Contributing
Pull requests are welcome.
