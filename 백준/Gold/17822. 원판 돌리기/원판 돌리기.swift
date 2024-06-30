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

let input = readLine()!.split(separator: " ").map{ Int($0)! }
let N = input[0]
let M = input[1]
let T = input[2]

var map = Array(repeating: Array(repeating: 0, count: M), count: N + 1)
var visited = Array(repeating: Array(repeating: false, count: M), count: N + 1)


for y in 1...N {
  let input = readLine()!.split(separator: " ").map{ Int($0)! }
  map[y] = input
}

for _ in 0..<T {
  let input = readLine()!.split(separator: " ").map{ Int($0)! }
  let x = input[0]
  let d = input[1]
  let k = input[2]
  var isSuccess = false
  visited = Array(repeating: Array(repeating: false, count: M), count: N + 1)
  turn(x: x, d: d, k: k)
  // 지우고 리턴 불값
  for y in 1...N {
    for x in 0..<M {
      if map[y][x] == 0 { continue }
      let value = bfs(start: (y: y, x: x))
      if !isSuccess {
        isSuccess = value
      }
    }
  }
  
  if !isSuccess {
    upDown()
  }
}

var result = 0

for y in 1...N {
  for x in 0..<M {
    result += map[y][x]
  }
}

print(result)

func upDown() {
  var points = [(y: Int, x: Int)]()
  var sum = 0
  
  for y in 1...N {
    for x in 0..<M {
      sum += map[y][x]
      if map[y][x] != 0 {
        points.append((y, x))
      }
    }
  }
  
  points.forEach {
    if Double(map[$0.y][$0.x]) < Double(sum) / Double(points.count) {
      map[$0.y][$0.x] += 1
    } else if Double(map[$0.y][$0.x]) > Double(sum) / Double(points.count) {
      map[$0.y][$0.x] -= 1
    }
  }
  
}

func bfs(start: (y: Int, x: Int)) -> Bool {
  var isSuccess = false
  let dy = [-1,0,1,0]
  let dx = [0,1,0,-1]
  var points: [(y: Int, x: Int)] = [start]
  var q = Queue<(y: Int, x: Int)>()
  visited[start.y][start.x] = true
  q.inQueue(element: start)
  
  while !q.isEmpty {
    let point = q.deQueue()
    
    for i in 0..<4 {
      var newX = (point.x + dx[i])
      
      if newX < 0 {
        newX = M - 1
      } else {
        newX = newX % M
      }
      
      let next: (y: Int, x: Int) = (y: point.y + dy[i], x: newX)
      if (1...N).contains(next.y) && map[next.y][next.x] != 0 &&
          !visited[next.y][next.x] &&
          map[point.y][point.x] == map[next.y][next.x] {
        q.inQueue(element: next)
        points.append(next)
        visited[next.y][next.x] = true
        isSuccess = true
      }
    }
  }
  
  if isSuccess {
    points.forEach {
      map[$0.y][$0.x] = 0
    }
  }
  
  return isSuccess
}

func turn(x: Int, d: Int, k: Int) {
  for y in 1..<map.count {
    guard y % x == 0 else { continue }
    switch d {
    case 0:
      let count = map[y].count
      let point = count - k
      map[y] = Array(map[y][point..<count] + map[y][0..<point])
    case 1:
      let count = map[y].count
      let point = k
      map[y] = Array(map[y][point..<count] + map[y][0..<point])
    default: break
    }
  }
}


