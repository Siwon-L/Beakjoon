let nm = readLine()!.split(separator: " ").map { Int($0)! }

let n = nm[0]
let m = nm[1]

var graph: [[Int]] = Array(repeating: Array(repeating: Int.max, count: n+1), count: n+1)

for i in 1...n { graph[i][i] = Int.max }

for _ in 0..<m {
  let input = readLine()!.split(separator: " ").map { Int($0)! }
  graph[input[0]][input[1]] = 1
  graph[input[1]][input[0]] = 1
}

for k in 1...n {
  for i in 1...n {
    for j in 1...n {
      if i == j || i == k || k == j { continue }
      if graph[i][k] == Int.max || graph[k][j] == Int.max { continue }
      graph[i][j] = min(graph[i][j], graph[i][k] + graph[k][j])
    }
  }
}

let result = graph[1...].map {
  $0[1...].reduce(into: 0) { partialResult, value in
    partialResult += (value == Int.max ? 0 : value)
  }
}
print(result.firstIndex(of: result.min()!)! + 1)