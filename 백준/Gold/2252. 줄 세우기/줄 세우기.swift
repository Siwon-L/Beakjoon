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
    if isEmpty { return nil }
    return elements[index]
  }
}


let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0]
let m = nm[1]
var link: [[Int]] = Array(repeating: [], count: n+1)
var depth = Array(repeating: 0, count: n+1)

for _ in 0..<m {
  let toFrom = readLine()!.split(separator: " ").map { Int($0)! }
  link[toFrom[0]].append(toFrom[1])
  depth[toFrom[1]] += 1
}

var result: [Int] = []
var queue = Queue<Int>()

for i in 1...n where depth[i] == 0 {
  queue.enqueue(i)
}

func bfs() {
  while let current = queue.dequeue() {
    result.append(current)
    for next in link[current] {
      depth[next] -= 1
      if depth[next] == 0 {
        queue.enqueue(next)
      }
    }
  }
}
bfs()
result.forEach { print($0, terminator: " ") }
