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
let L = input[1]
let R = input[2]
var map = [[Int]]()
var visited = Array(repeating: Array(repeating: false, count: N), count: N)
let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

for _ in 0..<N {
  let input = readLine()!.split(separator: " ").map { Int($0)! }
  map.append(input)
}

var result = 0
var isSucess = false
mainLoop: repeat {
  isSucess = false
  visited = Array(repeating: Array(repeating: false, count: N), count: N)
  for y in 0..<N {
    for x in 0..<N {
      let point = Point(y: y, x: x)
      if isMovable(point) {
        bfs(point)
        isSucess = true
      }
    }
  }
  if isSucess { result += 1 }
} while isSucess

print(result)

func bfs(_ start: Point) {
  visited[start.y][start.x] = true
  var count = 1
  var arr = [start]
  var num = map[start.y][start.x]
  var q = Queue<Point>()
  q.inQueue(start)
  
  while !q.isEmpty {
    let point = q.deQueue()
    
    for i in 0..<4 {
      let next = Point(y: point.y + dy[i], x: point.x + dx[i])
      if (0..<N).contains(next.y) && (0..<N).contains(next.x) &&
      !visited[next.y][next.x] &&
      abs(map[next.y][next.x] - map[point.y][point.x]) >= L &&
      abs(map[next.y][next.x] - map[point.y][point.x])  <= R {
        
        visited[next.y][next.x] = true
        arr.append(next)
        count += 1
        num += map[next.y][next.x]
        q.inQueue(next)
      }
    }
  }
  arr.forEach {
    map[$0.y][$0.x] = Int(num / count)
  }
}

func isMovable(_ point: Point) -> Bool {
  if visited[point.y][point.x] { return false }
  for i in 0..<4 {
    let next = Point(y: point.y + dy[i], x: point.x + dx[i])
    if (0..<N).contains(next.y) && (0..<N).contains(next.x) && !visited[next.y][next.x] {
      if abs(map[next.y][next.x] - map[point.y][point.x]) >= L &&
      abs(map[next.y][next.x] - map[point.y][point.x])  <= R {
        return true
      }
    }
  }
  return false
}







