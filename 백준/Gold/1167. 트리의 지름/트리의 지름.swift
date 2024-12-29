import Foundation

struct Node {
  let num: Int
  let leng: Int
}

let n = Int(readLine()!)!

var link: [[Node]] = Array(repeating: [], count: n + 1)
var visited = Array(repeating: false, count: n + 1)

for i in 1...n {
  let input = readLine()!.split(separator: " ").map { Int($0)! }
  for j in 1..<input.count / 2 {
    link[input[0]].append(Node(num: input[j*2-1], leng: input[j*2]))
  }
}

func dfs(start: Int, leng: Int) {
  if result < leng {
    result = leng
    endNodeNum = start
  }
  
  for node in link[start] {
    let next = node.num
    if !visited[next] {
      visited[next] = true
      dfs(start: next, leng: leng + node.leng)
      visited[next] = false
    }
  }
}

var result = 0
var endNodeNum = -1

visited[1] = true
dfs(start: 1, leng: 0)
visited[1] = false

visited[endNodeNum] = true
dfs(start: endNodeNum, leng: 0)
visited[endNodeNum] = false

print(result)
