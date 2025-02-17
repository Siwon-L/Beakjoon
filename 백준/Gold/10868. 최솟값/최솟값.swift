struct SegmentTree {
  var tree: [Int]
  private var nums: [Int]
  private var N: Int
  private let calculation: (Int, Int) -> Int
  
  init(nums: [Int], calculation: @escaping (Int, Int) -> Int) {
    self.nums = nums
    self.N = nums.count
    self.tree = Array(repeating: 0, count: N * 4)
    self.calculation = calculation
    makeSegmentTree(range: (s: 0, e: N-1), node: 1)
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
  
  func search(left: Int, right: Int) -> Int {
    return search(range: (s: 0, e: N-1), node: 1, left: left, right: right)
  }
  
  private func search(range: (s: Int, e: Int), node: Int, left: Int, right: Int) -> Int {
    if right < range.s || left > range.e {
      return 0
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
    update(range: (s: 0, e: N-1), node: 1, at: index, diff: value - nums[index])
    nums[index] = value
  }
  
  mutating private func update(range: (s: Int, e: Int), node: Int, at index: Int, diff: Int) {
    if (range.s...range.e) ~= index {
      tree[node] += diff
      if range.s == range.e { return }
    } else { return }
    
    let mid = (range.s + range.e) / 2
    update(range: (s: range.s, e: mid), node: node * 2, at: index, diff: diff)
    update(range: (s: mid+1, e: range.e), node: node * 2 + 1, at: index, diff: diff)
  }
}

let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
let n = nm[0]
let m = nm[1]

var nums: [Int] = []

for _ in 0..<n {
  let input = Int(readLine()!)!
  nums.append(input)
}

var segmentTree = SegmentTree(nums: nums) { left, right in
  if left != 0, right != 0 {
    return min(left, right)
  } else if left == 0 {
    return right
  } else if right == 0 {
    return left
  } else {
    return 0
  }
}
var result: [Int] = []

for _ in 0..<m {
  let ab = readLine()!.split(separator: " ").compactMap { Int($0) }
  let a = ab[0]
  let b = ab[1]
  
  result.append(segmentTree.search(left: a-1, right: b-1))
}

result.forEach {
  print($0)
}
