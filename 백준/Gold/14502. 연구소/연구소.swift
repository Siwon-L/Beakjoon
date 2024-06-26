struct Queue<T> {
  var memory = [T]()
  var index = 0
  var isEmpty: Bool {
    memory.count < index + 1
  }
  
  mutating func inQueue(_ element: T) {
    memory.append(element)
  }
  
  mutating func deQueue() -> T {
    let v = memory[index]
    index += 1
    return v
  }
}

struct Point: Equatable, Hashable {
  let y: Int
  let x: Int
}

let input = readLine()!.split(separator: " ").map { Int($0)! }
let N = input[0]
let M = input[1]
var map = [[Int]]()
var visited = Array(repeating: Array(repeating: false, count: M), count: N)
var emptyPoints = [Point]()
var virusPoints = [Point]()

for y in 0..<N {
  let input = readLine()!.split(separator: " ").map { Int($0)! }
  map.append(input)
  for x in 0..<M {
    if input[x] == 0 { emptyPoints.append(Point(y: y, x: x)) }
    else if input[x] == 2 { virusPoints.append(Point(y: y, x: x)) }
  }
}

var emptyVisited = Array(repeating: false, count: emptyPoints.count)

func bfs(starts: [Point], walls: Set<Point>) -> Int {
  var count = 0
  let dy = [-1,0,1,0]
  let dx = [0,1,0,-1]
  
  var q = Queue<Point>()
  starts.forEach { q.inQueue($0) }
  
  while !q.isEmpty {
    let point = q.deQueue()
    
    for i in 0..<4 {
      let next = Point(y: point.y + dy[i], x: point.x + dx[i])
      if (0..<N).contains(next.y) && (0..<M).contains(next.x) &&
      !walls.contains(next) &&
      !visited[next.y][next.x] &&
      map[next.y][next.x] == 0 {
        visited[next.y][next.x] = true
        count += 1
        q.inQueue(next)
      }
    }
  }
  return count
}

func dfs(start: Int, walls: [Point]) {
  var newWalls = walls
  if walls.count == 3 {
    visited = Array(repeating: Array(repeating: false, count: M), count: N)
    result = max(result, emptyPoints.count - bfs(starts: virusPoints, walls: Set(walls)) - 3)
    return
  }
  
  for i in start..<emptyPoints.count {
    if emptyVisited[i] { continue }
    emptyVisited[i] = true
    newWalls.append(emptyPoints[i])
    dfs(start: i + 1, walls: newWalls)
    newWalls.removeLast()
    emptyVisited[i] = false
  }
}

var result = 0

dfs(start: 0, walls: [])
print(result)








