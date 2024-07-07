class Queue {
  var memory = [Int]()
  var index = 0
  var sum = 0
  
  func inQueue(_ element: Int) {
    sum += element
    memory.append(element)
  }
  
  func deQueue() -> Int {
    let element = memory[index]
    index += 1
    sum -= element
    return element
  }
  
  var count: Int {
    return memory.count
  }
  
  var isEmpty: Bool {
    return count < index + 1
  }
  
  var arr: [Int] {
    return Array(memory[index..<memory.count])
  }
}

let input = readLine()!.split(separator: " ").map { Int($0)! }
let n = input[0]
let w = input[1]
let l = input[2]
var trucks = readLine()!.split(separator: " ").reversed().map({ Int($0)! })

var result = 0
let queue = Queue()
while true {
  if trucks.isEmpty && queue.arr.filter({ $0 != 0 }).isEmpty { break }
  result += 1
  if queue.count >= w  {
    queue.deQueue()
  }
  
  if !trucks.isEmpty && queue.sum + trucks.last! <= l {
    let element = trucks.removeLast()
    queue.inQueue(element)
  }  else {
    queue.inQueue(0)
  }
}

print(result)






