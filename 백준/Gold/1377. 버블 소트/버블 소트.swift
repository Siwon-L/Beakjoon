import Foundation

var arr = [(p: Int, v: Int)]()
let n = Int(readLine()!)!

for i in 0..<n {
  arr.append((i, Int(readLine()!)!))
}

var sorted = arr.sorted { $0.v < $1.v }

var changedPositions: [Int] = []

for i in 0..<n {
  changedPositions.append(sorted[i].p - i)
}
print(changedPositions.max()! + 1)
