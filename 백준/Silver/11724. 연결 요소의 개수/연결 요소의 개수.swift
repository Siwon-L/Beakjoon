let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0]
let m = nm[1]

var link = Array(repeating: Array(repeating: false, count: n + 1), count: n + 1)
var visited = Array(repeating: false, count: n + 1)

for _ in 0..<m {
  let uv = readLine()!.split(separator: " ").map { Int($0)! }
  let u = uv[0]
  let v = uv[1]
  link[u][v] = true
  link[v][u] = true
}

func dfs(start: Int) {
  visited[start] = true
  
  for i in 1...n {
    if visited[i] == false && link[start][i] {
      dfs(start: i)
    }
  }
}

var result = 0

for i in 1...n {
  if visited[i] == false {
    result += 1
    dfs(start: i)
  }
}

print(result)