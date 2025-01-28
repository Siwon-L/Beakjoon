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


let n = Int(readLine()!)!
var link: [[Int]] = Array(repeating: [], count: n+1)
var depth = Array(repeating: 0, count: n+1)
var times = Array(repeating: 0, count: n+1)

for i in 1...n {
  let inputs = readLine()!.split(separator: " ").map { Int($0)! }
  for (j, input) in inputs.enumerated() {
    if input == -1 { break }
    if j == 0 { times[i] = input; continue } else {
      link[input].append(i)
      depth[i] += 1
    }
  }
}

var result = Array(repeating: 0, count: n+1)
var queue = Queue<Int>()

for i in 1...n where depth[i] == 0 {
  queue.enqueue(i)
  result[i] = times[i]
}

while let current = queue.dequeue() {
  for next in link[current] {
    depth[next] -= 1
    result[next] = max(result[current] + times[next], result[next])
    if depth[next] == 0 {
      queue.enqueue(next)
    }
  }
}

result[1...].forEach { print($0) }
