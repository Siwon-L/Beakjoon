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

func solution() {
    let nk = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = nk[0]
    let k = nk[1]
    var jewels = [(m: Int, v: Int)]()
    for _ in 0..<n {
        let jewel = readLine()!.split(separator: " ").compactMap { Int($0) }
        jewels.append((jewel[0], jewel[1]))
    }
    var bags = [Int]()
    for _ in 0..<k {
        let bag = Int(readLine()!)!
        bags.append(bag)
    }
    jewels.sort { $0.m < $1.m }
    bags.sort(by: <)
    var result = 0
    var jewelIndex = 0
    var heap = Heap<(m: Int, v: Int)> { $0.v > $1.v } 
    for bag in bags {
        while jewelIndex < n, bag >= jewels[jewelIndex].m {
            heap.insert(jewels[jewelIndex])
            jewelIndex += 1
        }
        result += heap.pop()?.v ?? 0

    }
    print(result)
    
}

solution()