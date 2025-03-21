import Foundation

struct Heap<T> {
  private var elements: [T] = []
  private let sortFunction: (T, T) -> Bool
  
  var isEmpty: Bool {
    elements.count < 2
  }
  
  var values: [T] {
    Array(elements[1..<elements.count])
  }

  var peek: T {
    elements[1]
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

func solution() {
    let n = Int(readLine()!)!
    var schedules = [(start: Int, end: Int)]()
    for i in 0..<n {
        let st = readLine()!.split(separator: " ").compactMap { Int($0) }
        schedules.append((st[0], st[1]))
    }
    schedules.sort {
       if $0.start < $1.start {
        return true
       } else if $0.start == $1.start {
         if $0.end < $1.end { return true }
       }
       return false
    }
    var heap = Heap<Int>(sortFunction: <)
    var count = 1
    heap.insert(schedules[0].end)
    for i in 1..<schedules.count {
      if heap.peek <= schedules[i].start {
        heap.pop()
        heap.insert(schedules[i].end)
      } else {
        heap.insert(schedules[i].end)
        count += 1
      }

    }
    print(count)
    
}

solution()
