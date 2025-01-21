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
var unionFine = UnionFind(count: n)

let countAndKnowers = readLine()!.split(separator: " ").map { Int($0)! }

if countAndKnowers[0] == 0 {
  print(m)
} else {
  let knowers = Array(countAndKnowers[1...])
  let rootKnower = knowers[0]
  for knower in knowers[1...] {
    unionFine.union(rootKnower, knower)
  }
  var partys = [[Int]]()
  for _ in 0..<m {
    let party = readLine()!.split(separator: " ").map { Int($0)! }
    for people in party[2...] {
      unionFine.union(party[1], people)
    }
    if unionFine.findParent(party[1]) == unionFine.findParent(rootKnower) {
      unionFine.union(party[1], rootKnower)
    }
    partys.append(party)
  }
  var count = 0
  for party in partys {
    if unionFine.findParent(party[1]) != unionFine.findParent(rootKnower) {
      count += 1
    }
  }
  print(count)
}
