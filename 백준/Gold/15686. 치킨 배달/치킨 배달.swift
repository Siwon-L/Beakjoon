import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0]
let m = nm[1]

var house = [(y: Int, x: Int)]()
var chicken = [(y: Int, x: Int)]()

for i in 0..<n {
  let y = readLine()!.split(separator: " ").map { Int($0)! }
  for j in 0..<n {
    if y[j] == 1 {
      house.append((y: i + 1, x: j + 1))
    } else if y[j] == 2 {
      chicken.append((y: i + 1, x: j + 1))
    }
  }
}
var visited = Array(repeating: false, count: chicken.count)
var result = Int.max

func calculate(picked: [(y: Int, x: Int)]) -> Int {
  var sum = 0
  for h in house {
    var distance = Int.max
    for t in picked {
      distance = min(distance, (abs(h.y - t.y) + abs(h.x - t.x)))
    }
    sum += distance
  }
  return sum
}

func pick(count: Int, start: Int, picked: [(y: Int, x: Int)]) {
  var newPicked = picked
  if count == m {
    result = min(result, calculate(picked: picked))
    return
  }
  for i in start..<chicken.count {
    if visited[i] { continue }
    visited[i] = true
    newPicked.append(chicken[i])
    pick(count: count + 1, start: i + 1, picked: newPicked)
    newPicked.removeLast()
    visited[i] = false
  }
}

pick(count: 0, start: 0, picked: [])
print(result)
