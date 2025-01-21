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
import Foundation

let ABC = readLine()!.split(separator: " ").map { Int($0)! }
let A = ABC[0]
let B = ABC[1]
let C = ABC[2]
var visited = Array(repeating: Array(repeating: false, count: B + 1), count: A + 1)

func bfs(start: (a: Int, b: Int)) {
  var queue = Queue<(a: Int, b: Int)>()
  queue.enqueue(start)
  while let current = queue.dequeue() {
    let a = current.a, b = current.b, c = C - a - b
    if visited[a][b] { continue }
    visited[a][b] = true
    if a > 0 {
      if a >= B - b {
        queue.enqueue((a: a-B+b, b: B))
      } else {
        queue.enqueue((a: 0, b: b+a))
      }
      if a >= C - c {
        queue.enqueue((a: a-C+c, b: b))
      } else {
        queue.enqueue((a: 0, b: b))
      }
    }
    if b > 0 {
      if b >= A - a {
        queue.enqueue((a: A, b: b-A+a))
      } else {
        queue.enqueue((a: a+b, b: 0))
      }
      if b >= C - c {
        queue.enqueue((a: a, b: b-C+c))
      } else {
        queue.enqueue((a: a, b: 0))
      }
    }
    if c > 0 {
      if c >= A - a {
        queue.enqueue((a: A, b: b))
      } else {
        queue.enqueue((a: a+c, b: b))
      }
      if c >= B - b {
        queue.enqueue((a: a, b: B))
      } else {
        queue.enqueue((a: a, b: b+c))
      }
    }
  }
}

bfs(start: (a: 0, b: 0))
var results = Set<Int>()
for b in 0...B where visited[0][b] {
  results.insert(C-b)
}
results.sorted(by: <).forEach {
  print($0, terminator: " ")
}
