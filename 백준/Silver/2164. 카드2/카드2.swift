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

var queue = Queue<Int>()

for i in 1...n {
  queue.enqueue(i)
}

while true {
  let f = queue.dequeue()
  if queue.isEmpty {
    print(f!)
    break
  }
  let s = queue.dequeue()
  queue.enqueue(s!)
}
