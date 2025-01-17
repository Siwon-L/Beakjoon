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


import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0]
let m = nm[1]

var link: [[Int]] = Array(repeating: [], count: n + 1)
var visited = Array(repeating: false, count: n + 1)
visited[0] = true
for _ in 0..<m {
  let fromTo = readLine()!.split(separator: " ").map { Int($0)! }
  let to = fromTo[1]
  let from = fromTo[0]
  link[to].append(from)
}

var results = Array(repeating: 0, count: n + 1)

func bfs(start: Int) -> Int {
  var count = 1
  var queue = Queue<Int>()
  visited[start] = true
  queue.enqueue(start)
  
  while !queue.isEmpty {
    let current = queue.dequeue()!
    for next in link[current] where !visited[next] {
      visited[next] = true
      queue.enqueue(next)
      count += 1
    }
  }
  return count
}

for i in 1...n {
  visited = Array(repeating: false, count: n + 1)
  results[i] = bfs(start: i)
}
let max = results.max()!
for i in 1...n {
  if results[i] == max {
    print(i, terminator: " ")
  }
}


