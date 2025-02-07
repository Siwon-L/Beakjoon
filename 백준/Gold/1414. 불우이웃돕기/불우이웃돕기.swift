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


let n = Int(readLine()!)!

var edges: [[(v: Int, e: Int)]] = Array(repeating: [], count: n+1)
var total = 0
for i in 1...n {
  let input = readLine()!.map { str -> Int in
    if (97...122) ~= str.asciiValue! {
      return Int(str.asciiValue! - 96)
    }  else if str == "0" {
      return 0
    } else {
      return Int(str.asciiValue! - 38)
    }
  }
  total += input.reduce(0, +)
  for j in 0..<n {
    if i == j+1 { continue }
    edges[i].append((v: j + 1, e: input[j]))
    edges[j+1].append((v: i, e: input[j]))
  }
}

var visited = Array(repeating: false, count: n + 1)
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
  print(-1)
} else {
  print(total - result)
}
