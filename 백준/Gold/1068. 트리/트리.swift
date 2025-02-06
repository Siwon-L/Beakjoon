let n = Int(readLine()!)!
var start: Int!
let parentsNodes = readLine()!.split(separator: " ").map { Int($0)! }
var childNode: [[Int]] = Array(repeating: [], count: n)
let target = Int(readLine()!)!
var result = 0

for i in 0..<parentsNodes.count {
  if parentsNodes[i] == -1 {
    start = i
    continue
  }
  childNode[parentsNodes[i]].append(i)
}

func solution() {
  if parentsNodes[target] == -1 {
    print(0)
    return
  } else {
    childNode[parentsNodes[target]].removeAll { $0 == target }
  }
  dfs(start: start)
  print(result)
}

func dfs(start: Int) {
  if childNode[start].count == 0 {
    result += 1
    return
  }
  
  for next in childNode[start] {
    dfs(start: next)
  }
}

solution()
