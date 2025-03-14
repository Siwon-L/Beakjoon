struct SegmentTree {
  var tree: [Int]
  var nums: [Int]
  private var N: Int
  private let calculation: (Int?, Int?) -> Int
  
  init(nums: [Int], calculation: @escaping (Int?, Int?) -> Int) {
    self.nums = nums
    self.N = nums.count
    self.tree = Array(repeating: 0, count: N * 4)
    self.calculation = calculation
    makeSegmentTree(range: (s: 0, e: N-1), node: 1)
  }
  
  @discardableResult
  mutating func makeSegmentTree() -> Int {
    return makeSegmentTree(range: (s: 0, e: N-1), node: 1)
  }
  
  @discardableResult
  mutating private func makeSegmentTree(range: (s: Int, e: Int), node: Int) -> Int {
    if range.s == range.e {
      tree[node] = nums[range.s]
      return tree[node]
    }
    let mid = (range.s + range.e) / 2
    let left = makeSegmentTree(range: (s: range.s, e: mid), node: node * 2)
    let right = makeSegmentTree(range: (s: mid+1, e: range.e), node: node * 2 + 1)
    
    tree[node] = calculation(left, right)
    return tree[node]
  }
  
  func search(left: Int, right: Int) -> Int? {
    return search(range: (s: 0, e: N-1), node: 1, left: left, right: right)
  }
  
  private func search(range: (s: Int, e: Int), node: Int, left: Int, right: Int) -> Int? {
    if right < range.s || left > range.e {
      return nil
    }
    
    if left <= range.s && right >= range.e {
      return tree[node]
    }
    
    let mid = (range.s + range.e) / 2
    let leftR = search(range: (s: range.s, e: mid), node: node * 2, left: left, right: right)
    let rightR = search(range: (s: mid+1, e: range.e), node: node * 2 + 1, left: left, right: right)
    
    return calculation(leftR, rightR)
  }
  
  mutating func update(at index: Int, value: Int) {
    update(range: (s: 0, e: N-1), node: 1, at: index, newValue: value)
    nums[index] = value
  }
  
  mutating private func update(range: (s: Int, e: Int), node: Int, at index: Int, newValue: Int) {
    guard (range.s...range.e) ~= index else { return }
    
    if range.s == range.e {
      tree[node] = newValue
      return
    }
    
    let mid = (range.s + range.e) / 2
    if index <= mid {
      update(range: (s: range.s, e: mid), node: node * 2, at: index, newValue: newValue)
    } else {
      update(range: (s: mid + 1, e: range.e), node: node * 2 + 1, at: index, newValue: newValue)
    }
    tree[node] = calculation(tree[node * 2], tree[node * 2 + 1])
  }
}
let nmk = readLine()!.split(separator: " ").compactMap { Int($0) }
let n = nmk[0]
let m = nmk[1]
let k = nmk[2]

var nums: [Int] = []

for _ in 0..<n {
  let input = Int(readLine()!)!
  nums.append(input)
}

var segmentTree = SegmentTree(nums: nums) { left, right in
  return ((left ?? 1) * (right ?? 1)) % 1_000_000_007
}
var results: [Int] = []

for _ in 0..<(m + k) {
  let abc = readLine()!.split(separator: " ").compactMap { Int($0) }
  let a = abc[0]
  let b = abc[1]
  let c = abc[2]
  
  if a == 1 {
    if segmentTree.nums[b-1] == 0 {
      segmentTree.nums[b-1] = c
      segmentTree.makeSegmentTree()
    } else {
      segmentTree.update(at: b-1, value: c)
    }
  } else {
    guard let result = segmentTree.search(left: b-1, right: c-1) else { continue }
    results.append(result)
  }
}

results.forEach {
  print($0)
}
