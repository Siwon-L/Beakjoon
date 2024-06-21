struct Queue<T> {
  var memory = [T]()
  var index = 0
  
  var isEmpty: Bool {
    memory.count < index + 1
  }
  
  mutating func inQueue(element: T) {
    memory.append(element)
  }
  
  mutating func deQueue() -> T {
    let v = memory[index]
    index += 1
    return v
  }
}

struct Point {
  let y: Int
  let x: Int
}

var map = [[Character]]()
var visited = Array(repeating: Array(repeating: false, count: 6), count: 12)
for _ in 0..<12 {
  let input = Array(readLine()!)
  map.append(input)
}

var result = 0

func bfs(_ start: Point, target: Character) -> Int {
  let dy = [-1,0,1,0]
  let dx = [0,1,0,-1]
  var q = Queue<Point>()
  q.inQueue(element: start)
  visited[start.y][start.x] = true
  arr.append(start)
  var count = 1
  while !q.isEmpty {
    let start = q.deQueue()
    for i in 0..<4 {
      let next = Point(y: start.y + dy[i], x: start.x + dx[i])
      if (0..<12).contains(next.y) &&
          (0..<6).contains(next.x) &&
          !visited[next.y][next.x] &&
          map[next.y][next.x] == target {
        visited[next.y][next.x] = true
        q.inQueue(element: next)
        arr.append(next)
        count += 1
      }
    }
  }
  return count
}

var isSeccese = false

var arr = [Point]()
func start() {
  visited = Array(repeating: Array(repeating: false, count: 6), count: 12)
  for x in 0..<6 {
    for y in (0..<12).reversed() {
      if map[y][x] != "." && !visited[y][x] {
        arr = [Point]()
        if bfs(Point(y: y, x: x), target: map[y][x]) >= 4 {
          isSeccese = true
          for point in arr {
            map[point.y][point.x] = "."
          }
        }
      }
    }
  }
}

func shift() {
  for x in 0..<6 {
    for y in (0..<12).reversed() {
      if map[y][x] != "." { continue }
      var k = y - 1
      while k >= 0 {
        if map[k][x] == "." { k -= 1; continue }
        map[y][x] = map[k][x]
        map[k][x] = "."
        break
      }
    }
  }
}

repeat {
  isSeccese = false
  start()
  shift()
  if isSeccese { result += 1 }
} while isSeccese

print(result)
