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

let nm = readLine()!.split(separator: " ").map{ Int($0)! }

let n = nm[0]
let m = nm[1]

var map = [[Int]]()
var distance = Array(repeating: Array(repeating: 1, count: m + 1), count: n + 1)

for _ in 0..<n {
  let y = readLine()!
  var arr = Array(y)
  arr.insert("0", at: 0)
  map.append(arr.map { Int(String($0))! })
}

map.insert(Array(repeating: 0, count: m + 1), at: 0)


func bfs(start: (y: Int, x: Int)) {
  let lrud: [(y: Int, x: Int)] = [
    (0,-1),
    (0,1),
    (-1,0),
    (1,0)
  ]
  var q = Queue<(y: Int, x: Int)>()
  q.inQueue(element: start)
  map[start.y][start.x] = 0

  while !q.isEmpty {
    let p = q.deQueue()

    for i in 0..<4 {
      let next: (y: Int, x: Int) = (p.y + lrud[i].y, p.x + lrud[i].x)
      if (1...n).contains(next.y) && (1...m).contains(next.x) {
        if map[next.y][next.x] == 1 {
          map[next.y][next.x] = 0
          distance[next.y][next.x] += distance[p.y][p.x]
          q.inQueue(element: next)
        }
      }
    }
  }
}

bfs(start: (1,1))
print(distance[n][m])
