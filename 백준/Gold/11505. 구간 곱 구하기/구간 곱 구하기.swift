let MOD = 1_000_000_007

struct SegmentTree {
  var tree: [Int]
  var nums: [Int]
  private var N: Int
  private let calculation: (Int?, Int?, Int?) -> Int
  
  init(nums: [Int], calculation: @escaping (Int?, Int?, Int?) -> Int) {
    self.nums = nums
    self.N = nums.count
    self.tree = Array(repeating: 0, count: N * 4)
    self.calculation = calculation
    _ = makeSegmentTree(range: (s: 0, e: N - 1), node: 1)
  }
  
  @discardableResult
  mutating func makeSegmentTree() -> Int {
    return makeSegmentTree(range: (s: 0, e: N - 1), node: 1)
  }
  
  @discardableResult
  mutating private func makeSegmentTree(range: (s: Int, e: Int), node: Int) -> Int {
    if range.s == range.e {
      tree[node] = nums[range.s] % MOD
      return tree[node]
    }
    let mid = (range.s + range.e) / 2
    let left = makeSegmentTree(range: (s: range.s, e: mid), node: node * 2)
    let right = makeSegmentTree(range: (s: mid + 1, e: range.e), node: node * 2 + 1)
    
    tree[node] = calculation(nil, left, right) % MOD
    return tree[node]
  }
  
  func search(left: Int, right: Int) -> Int? {
    return search(range: (s: 0, e: N - 1), node: 1, left: left, right: right)
  }
  
  private func search(range: (s: Int, e: Int), node: Int, left: Int, right: Int) -> Int? {
    // 구간에 겹치지 않으면 nil 반환
    if right < range.s || left > range.e {
      return nil
    }
    
    // 구간에 완전히 포함되는 경우
    if left <= range.s && right >= range.e {
      return tree[node]
    }
    
    let mid = (range.s + range.e) / 2
    let leftResult = search(range: (s: range.s, e: mid), node: node * 2, left: left, right: right)
    let rightResult = search(range: (s: mid + 1, e: range.e), node: node * 2 + 1, left: left, right: right)
    
    return calculation(nil, leftResult, rightResult) % MOD
  }
  
  mutating func update(at index: Int, value: Int) {
    update(range: (s: 0, e: N - 1), node: 1, at: index, newValue: value)
    nums[index] = value
  }
  
  // 재귀적으로 구간에 포함된 노드들의 값을 다시 계산
  mutating private func update(range: (s: Int, e: Int), node: Int, at index: Int, newValue: Int) {
    if index < range.s || index > range.e { return }
    
    if range.s == range.e {
      tree[node] = newValue % MOD
      return
    }
    
    let mid = (range.s + range.e) / 2
    if index <= mid {
      update(range: (s: range.s, e: mid), node: node * 2, at: index, newValue: newValue)
    } else {
      update(range: (s: mid + 1, e: range.e), node: node * 2 + 1, at: index, newValue: newValue)
    }
    tree[node] = (tree[node * 2] * tree[node * 2 + 1]) % MOD
  }
}

let inputLine = readLine()!.split(separator: " ").compactMap { Int($0) }
let n = inputLine[0]
let m = inputLine[1]
let k = inputLine[2]

var nums: [Int] = []
for _ in 0..<n {
  let num = Int(readLine()!)!
  nums.append(num)
}

var segmentTree = SegmentTree(nums: nums) { _, left, right in
  return ((left ?? 1) * (right ?? 1)) % MOD
}

var results: [Int] = []
for _ in 0..<(m + k) {
  let abc = readLine()!.split(separator: " ").compactMap { Int($0) }
  let a = abc[0]
  let b = abc[1]
  let c = abc[2]
  
  if a == 1 {
    segmentTree.update(at: b - 1, value: c)
  } else {
    if let result = segmentTree.search(left: b - 1, right: c - 1) {
      results.append(result)
    }
  }
}

results.forEach {
  print($0)
}