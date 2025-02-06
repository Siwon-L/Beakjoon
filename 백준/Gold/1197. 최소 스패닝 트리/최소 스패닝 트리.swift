import Foundation

struct Edge {
  let a: Int
  let b: Int
  let c: Int
}

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

let ve = readLine()!.split(separator: " ").compactMap { Int($0) }
let v = ve[0]
let e = ve[1]
var edges = [Edge]()
for _ in 0..<e {
  let input = readLine()!.split(separator: " ").compactMap { Int($0) }
  edges.append(.init(a: input[0], b: input[1], c: input[2]))
}

edges.sort { $0.c < $1.c }

var unionFind = UnionFind(count: v)
var result = 0

for edge in edges {
  if unionFind.findParent(edge.a) != unionFind.findParent(edge.b) {
    unionFind.union(edge.a, edge.b)
    result += edge.c
  }
}

print(result)
