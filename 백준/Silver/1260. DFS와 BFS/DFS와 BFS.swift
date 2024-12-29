let nmv = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nmv[0]
let m = nmv[1]
let v = nmv[2]

var link = Array(repeating: Array(repeating: false, count: n + 1), count: n + 1)
var visited = Array(repeating: false, count: n + 1)
var result = [Int]()

for _ in 0..<m {
  let value = readLine()!.split(separator: " ").map { Int(String($0))! }
  link[value[0]][value[1]] = true
  link[value[1]][value[0]] = true
}

func dfs(start: Int) {
  visited[start] = true
  result.append(start)
  for i in 1...n {
    if link[start][i] && visited[i] == false {
      dfs(start: i)
    }
  }
}

func bfs(start: Int) {
  let queue = CustomQueue<Int>()
  visited[start] = true
  queue.inQueue(start)
  
  while !queue.isEmpty {
    let newStart = queue.deQueue()
    result.append(newStart)
    
    for i in 1...n {
      if link[newStart][i] && visited[i] == false {
        queue.inQueue(i)
        visited[i] = true
      }
    }
  }
}

dfs(start: v)
print(result.map { String($0) }.joined(separator: " "))
visited = Array(repeating: false, count: n + 1)
result = [Int]()

bfs(start: v)
print(result.map { String($0) }.joined(separator: " "))


class CustomQueue<T> {
  var memory = [T]()
  var memoryIndex = 0
  
  var isEmpty: Bool {
    memory.count < memoryIndex + 1
  }
  
  func inQueue(_ element: T) {
    memory.append(element)
  }
  
  func deQueue() -> T {
    let value = memory[memoryIndex]
    memoryIndex += 1
    return value
  }
}

