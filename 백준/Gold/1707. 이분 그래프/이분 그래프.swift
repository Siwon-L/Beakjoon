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

let k = Int(readLine()!)!
var results = [String]()
for _ in 0..<k {
  let ve = readLine()!.split(separator: " ").map { Int($0)! }
  let v = ve[0]
  let e = ve[1]

  var links: [[Int]] = Array(repeating: [], count: v + 1)
  var nodeColors = Array(repeating: -1, count: v + 1)

  for _ in 0..<e {
    let v = readLine()!.split(separator: " ").map { Int($0)! }
    links[v[0]].append(v[1])
    links[v[1]].append(v[0])
  }

  var q = Queue<Int>()
  var result = "YES"
  
  func bfs(start: Int) {
    nodeColors[start] = 0
    q.inQueue(element: start)
    while !q.isEmpty {
      let c = q.deQueue()
      for i in links[c] {
        if nodeColors[i] == -1 {
          nodeColors[i] = nodeColors[c]^1
          q.inQueue(element: i)
        } else if nodeColors[i] == nodeColors[c] {
          result = "NO"
          return
        }
      }
    }
  }
  
  for i in 1...v {
    if nodeColors[i] == -1 {
      bfs(start: i)
      if result == "NO" { break }
    }
  }
  results.append(result)
}

results.forEach {
  print($0)
}
