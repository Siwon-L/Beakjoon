import Foundation

struct Heap<T: Comparable> {
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

var heap = Heap<Int>(sortFunction: <)
for _ in 0..<n {
  let cardCount = Int(readLine()!)!
  heap.insert(cardCount)
}

var result = 0

while true {
  if heap.values.count <= 1 {
    break
  }
  let left = heap.pop()!
  let right = heap.pop()!
  result += left + right
  if heap.isEmpty { break }
  heap.insert(left + right)
}

print(result)
