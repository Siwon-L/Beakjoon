import Foundation

struct UnionFind {
  var parent: [Int]
  
  init(count: Int) {
    parent = [Int](0...count)
  }
  
  mutating func findParent(_ element: Int) -> Int {
    if parent[element] == element { return element }
    parent[element] = findParent(parent[element])
    return parent[element]
  }
  
  mutating func union(_ frist: Int, _ second: Int) {
    let fristParent = findParent(frist)
    let secondParent = findParent(second)
    if fristParent < secondParent {
      parent[secondParent] = fristParent
    } else {
      parent[fristParent] = secondParent
    }
  }
}

let n = Int(readLine()!)!
let m = Int(readLine()!)!
var unionFine = UnionFind(count: n)

for i in 1...n {
  let input = readLine()!.split(separator: " ").map { Int($0)! }
  for (j, element) in input.enumerated() {
    if element == 1 {
      unionFine.union(i, j + 1)
    }
  }
}

let plan = readLine()!.split(separator: " ").map { Int($0)! }
let temp = unionFine.findParent(plan[0])
if plan.filter({ temp != unionFine.findParent($0) }).isEmpty {
  print("YES")
} else {
  print("NO")
}

