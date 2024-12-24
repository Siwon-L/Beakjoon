import Foundation

let N = Int(readLine()!)!
var nums: [(index: Int, value: Int)] = readLine()!.split(separator: " ").enumerated().map { i, v in (i, Int(v)!) }
var tree = Array(repeating: 0, count: 4 * N)
var result = 0

nums.sort { $0.value < $1.value }

func readTree(min: Int, max: Int, node: Int, start: Int, end: Int) -> Int {
  guard start <= max, end >= min else {
    return 0
  }
  
  if start <= min, end >= max {
    return tree[node]
  }
  
  let mid = (min + max) / 2
  let left = readTree(min: min, max: mid, node: node * 2, start: start, end: end)
  let rigth = readTree(min: mid + 1, max: max, node: node * 2 + 1, start: start, end: end)
  return left + rigth
}

func updateTree(min: Int, max: Int, node: Int, target: Int) {
  guard (min...max) ~= target else {
    return
  }
  tree[node] += 1
  if min == max { return }
  let mid = (min + max) / 2
  updateTree(min: min, max: mid, node: node * 2, target: target)
  updateTree(min: mid + 1, max: max, node: node * 2 + 1, target: target)
}

for (i, _) in nums {
  result += readTree(min: 0, max: N-1, node: 1, start: i, end: N-1)
  updateTree(min: 0, max: N-1, node: 1, target: i)
}

print(result)
