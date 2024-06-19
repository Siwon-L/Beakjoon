import Foundation

struct Queue<T: Equatable> {
  var memory = [T]()
  var index = 0
  var isEmpty: Bool {
    memory.count < index + 1
  }
  
  var back: T {
    memory.last!
  }
  
  var front: T {
    memory[index]
  }
  
  func contains(_ element: T) -> Bool {
    return memory[index...].contains(element)
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

enum Direction {
  case t
  case r
  case l
  case b
}

struct Point: Hashable, Equatable {
  let y: Int
  let x: Int
}

struct XC: Hashable, Equatable {
  let x: Int
  let c: String
}

let n = Int(readLine()!)!
var apple = Set<Point>()
var snake = Queue<Point>()
var xc = Queue<XC>()
snake.inQueue(element: .init(y: 1, x: 1))
for _ in 0..<Int(readLine()!)! {
  let yx = readLine()!.split(separator: " ").map { Int($0)! }
  apple.insert(Point(y: yx[0], x: yx[1]))
}
let l = Int(readLine()!)!

for _ in 0..<l {
  let input = readLine()!.split(separator: " ")
  xc.inQueue(element: .init(x: Int(input[0])!, c: String(input[1])))
}

var direction: Direction = .r
var time = 0
start()
print(time)

func start() {
  while true {
    let point = snake.back
    let y = point.y
    let x = point.x
    time += 1
    let nextPoint: Point
    switch direction {
    case .t:
      nextPoint = .init(y: y - 1, x: x)
    case .r:
      nextPoint = .init(y: y, x: x + 1)
    case .l:
      nextPoint = .init(y: y, x: x - 1)
    case .b:
      nextPoint = .init(y: y + 1, x: x)
    }
    if !move(nextPoint) { return }
    if !(1...n).contains(nextPoint.y) || !(1...n).contains(nextPoint.x) {
      return
    }
    
    if !xc.isEmpty && time == xc.front.x {
      let v = xc.deQueue()
      turn(v.c)
    }
  }
}

func turn(_ v: String) {
  switch direction {
  case .t:
    direction = v == "D" ? .r : .l
  case .r:
    direction = v == "D" ? .b : .t
  case .l:
    direction = v == "D" ? .t : .b
  case .b:
    direction = v == "D" ? .l : .r
  }
}

func move(_ nextPoint: Point) -> Bool {

  if snake.contains(nextPoint) {
    return false
  }
  snake.inQueue(element: nextPoint)
  if apple.contains(nextPoint) {
    apple.remove(nextPoint)
  } else {
    snake.deQueue()
  }
  return true
}
