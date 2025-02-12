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

struct Heap<T> {
  private var elements: [T] = []
  private let sortFunction: (T, T) -> Bool
  
  var isEmpty: Bool {
    elements.count < 2
  }
  
  var values: [T] {
    Array(elements[1..<elements.count])
  }
  
  init(sortFunction: @escaping (T, T) -> Bool) {
    self.sortFunction = sortFunction
  }
  
  mutating func insert(_ element: T) {
    if elements.isEmpty {
      elements.append(element)
      elements.append(element)
      return
    }
    
    elements.append(element)
    moveUp(insertIndex: elements.count - 1)
  }
  
  mutating func pop() -> T? {
    if isEmpty { return nil }
    
    let returnValue = elements[1]
    elements.swapAt(1, elements.count - 1)
    elements.removeLast()
    
    moveDown(popIndex: 1)
    return returnValue
  }
  
  mutating private func moveUp(insertIndex: Int) {
    var index = insertIndex
    while index > 1, sortFunction(elements[index], elements[index/2]) {
      elements.swapAt(index, index/2)
      index = index/2
    }
  }
  
  mutating private func moveDown(popIndex: Int) {
    var index = popIndex
    let leftIndex = index * 2
    let rightIndex = index * 2 + 1
    
    if leftIndex < elements.count, sortFunction(elements[leftIndex], elements[index]) {
      index = leftIndex
    }
    
    if rightIndex < elements.count, sortFunction(elements[rightIndex], elements[index]) {
      index = rightIndex
    }
    
    if index != popIndex {
      elements.swapAt(index, popIndex)
      moveDown(popIndex: index)
    }
  }
}

let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
let n = nm[0]
let m = nm[1]

var edges: [[(v: Int, e: Int)]] = Array(repeating: [], count: 7)
var map = [[Int]]()
for _ in 0..<n {
  let input = readLine()!.split(separator: " ").compactMap { Int($0 == "1" ? "7" : "0") }
  map.append(input)
}

var visited = Array(repeating: Array(repeating: false, count: m), count: n)
var islands = [6,5,4,3,2,1]

for i in 0..<n {
  for j in 0..<m {
    if map[i][j] == 7, visited[i][j] == false {
      bfs(start: (y: i, x: j), island: islands.removeLast())
    }
  }
}

for i in 0..<n {
  for j in 0..<m {
    if map[i][j] != 0 {
      if (0..<n) ~= i-1, map[i-1][j] == 0 {
        dfs(start: (y: i-1, x: j), count: 1, target: map[i][j], direction: (y: -1, x: 0))
      }
      if (0..<m) ~= j+1, map[i][j+1] == 0 {
        dfs(start: (y: i, x: j+1), count: 1, target: map[i][j], direction: (y: 0, x: 1))
      }
      if (0..<n) ~= i+1, map[i+1][j] == 0 {
        dfs(start: (y: i+1, x: j), count: 1, target: map[i][j], direction: (y: 1, x: 0))
      }
      if (0..<m) ~= j-1, map[i][j-1] == 0 {
        dfs(start: (y: i, x: j-1), count: 1, target: map[i][j], direction: (y: 0, x: -1))
      }
    }
  }
}

print(mst(edges: edges))

func dfs(start: (y: Int, x: Int), count: Int, target: Int, direction: (y: Int, x: Int)) {
  
  let next = (y: start.y + direction.y, x: start.x + direction.x)
  if (0..<n) ~= next.y, (0..<m) ~= next.x {
    if map[next.y][next.x] == 0 {
      dfs(start: next, count: count + 1, target: target, direction: direction)
    } else if map[next.y][next.x] != 0, count > 1 {
      edges[target].append((v: map[next.y][next.x], e: count))
    }
  }
}


func bfs(start: (y: Int, x: Int), island: Int) {
  visited[start.y][start.x] = true
  map[start.y][start.x] = island
  var queue = Queue<(y: Int, x: Int)>()
  queue.enqueue(start)
  
  let dy = [-1,0,1,0]
  let dx = [0,1,0,-1]
  
  while let currnet = queue.dequeue() {
    for i in 0..<4 {
      let ny = currnet.y + dy[i]
      let nx = currnet.x + dx[i]
      if (0..<n) ~= ny, (0..<m) ~= nx, !visited[ny][nx], map[ny][nx] == 7 {
        visited[ny][nx] = true
        map[ny][nx] = island
        queue.enqueue((y: ny, x: nx))
      }
    }
  }
}

func mst(edges: [[(v: Int, e: Int)]]) -> Int {
  var visited = Array(repeating: false, count: 7-islands.count)
  var result = 0
  var heap = Heap<(v: Int, e: Int)>(sortFunction: { $0.e < $1.e })
  heap.insert((v: 1, e: 0))
  while let (curr, cost) = heap.pop() {
    if !visited[curr] {
      result += cost
      visited[curr] = true
    }
    for (next, nextCost) in edges[curr] {
      if nextCost == 0 { continue }
      if !visited[next] {
        heap.insert((v: next, e: nextCost))
      }
    }
  }
  
  if visited[1...].contains(false) {
    return -1
  } else {
    return result
  }
}
