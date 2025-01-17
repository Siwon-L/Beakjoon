import Foundation

struct Queue<T> {
  var elements: [T] = []
  var index: Int = 0
  
  var isEmpty: Bool {
    !(elements.count > index)
  }
  
  mutating func enqueue(_ element: T) {
    elements.append(element)
  }
  
  mutating func dequeue() -> T? {
    defer {
      index += 1
    }
    return elements[index]
  }
}

let nmkx = readLine()!.split(separator: " ").map { Int($0)! }
let n = nmkx[0]
let m = nmkx[1]
let k = nmkx[2]
let x = nmkx[3]
var link: [[Int]] = Array(repeating: [], count: n + 1)
var visited = Array(repeating: false, count: n + 1)

for _ in 0..<m {
  let toFrom = readLine()!.split(separator: " ").map { Int($0)! }
  let to = toFrom[0]
  let from = toFrom[1]
  link[to].append(from)
}

var count = 0
var result: [Int] = []

func bfs(start: Int) {
  var queue = Queue<(point: Int, count: Int)>()
  visited[start] = true
  queue.enqueue((start, 0))
  
  while !queue.isEmpty {
    let current = queue.dequeue()!
    if current.count == k {
      result.append(current.point)
      continue
    }
    for next in link[current.point] where !visited[next] {
      visited[next] = true
      queue.enqueue((next, current.count + 1))
    }
  }
}

bfs(start: x)

if result.isEmpty {
  print(-1)
} else {
  result.sorted(by: <).forEach {
    print($0)
  }
}

