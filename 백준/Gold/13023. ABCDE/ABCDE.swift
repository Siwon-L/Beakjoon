import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0], m = nm[1]

var link: [[Int]] = Array(repeating: [], count: n)
var visited = Array(repeating: false, count: n)

for _ in 0..<m {
  let fromTo = readLine()!.split(separator: " ").map { Int($0)! }
  let from = fromTo[0], to = fromTo[1]
  link[from].append(to)
  link[to].append(from)
}

var result = 0

func dfs(start: Int, count: Int) {
  if count == 4 {
    result = 1
    return
  }
  
  for next in link[start] {
    if !visited[next], result == 0 {
      visited[next] = true
      dfs(start: next, count: count + 1)
      visited[next] = false
    }
  }
}


for i in 0..<n {
  if !visited[i], result == 0 {
    visited[i] = true
    dfs(start: i, count: 0)
    visited[i] = false
  }
}

print(result)
