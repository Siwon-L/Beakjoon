let n = Int(readLine()!)!
let m = Int(readLine()!)!

var graph: [[Int]] = Array(repeating: Array(repeating: Int.max, count: n+1), count: n+1)

for i in 1...n { graph[i][i] = 0 }

for _ in 0..<m {
  let input = readLine()!.split(separator: " ").map { Int($0)! }
  if graph[input[0]][input[1]] == 0 { graph[input[0]][input[1]] = input[2]; continue }
  graph[input[0]][input[1]] = min(input[2], graph[input[0]][input[1]])
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

graph[1...].forEach {
  print($0[1...].map {
    String($0 == Int.max ? 0 : $0)
  }.joined(separator: " "))
}