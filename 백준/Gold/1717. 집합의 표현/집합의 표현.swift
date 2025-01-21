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


let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0], m = nm[1]
var result = ""
var unionFind = UnionFind(count: n)
for _ in 0..<m {
  let cab = readLine()!.split(separator: " ").map { Int($0)! }
  let command = cab[0], a = cab[1], b = cab[2]
  switch command {
  case 0:
    unionFind.union(a, b)
  case 1:
    if unionFind.findParent(a) == unionFind.findParent(b) {
      result.append("YES\n")
    } else {
      result.append("NO\n")
    }
  default: break
  }
}

print(result)


