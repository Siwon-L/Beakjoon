struct SegmentTree {
  var tree: [Int]
  private var nums: [Int]
  private var N: Int
  
  init(nums: [Int]) {
    self.nums = nums
    self.N = nums.count
    self.tree = Array(repeating: 0, count: N * 4)
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
    
    tree[node] = left + right
    return tree[node]
  }
  
  func sum(left: Int, right: Int) -> Int {
    return sum(range: (s: 0, e: N-1), node: 1, left: left, right: right)
  }
  
  private func sum(range: (s: Int, e: Int), node: Int, left: Int, right: Int) -> Int {
    if right < range.s || left > range.e {
      return 0
    }
    
    if left <= range.s && right >= range.e {
      return tree[node]
    }
    
    let mid = (range.s + range.e) / 2
    let leftSum = sum(range: (s: range.s, e: mid), node: node * 2, left: left, right: right)
    let rightSum = sum(range: (s: mid+1, e: range.e), node: node * 2 + 1, left: left, right: right)
    
    return leftSum + rightSum
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

let nmk = readLine()!.split(separator: " ").compactMap { Int($0) }
let n = nmk[0]
let m = nmk[1]
let k = nmk[2]

var nums: [Int] = []

for _ in 0..<n {
  let input = Int(readLine()!)!
  nums.append(input)
}

var segmentTree = SegmentTree(nums: nums)
var result: [Int] = []

for _ in 0..<(m + k) {
  let abc = readLine()!.split(separator: " ").compactMap { Int($0) }
  let a = abc[0]
  let b = abc[1]
  let c = abc[2]
  
  if a == 1 {
    segmentTree.update(at: b-1, value: c)
  } else {
    result.append(segmentTree.sum(left: b-1, right: c-1))
  }
}

result.forEach {
  print($0)
}

