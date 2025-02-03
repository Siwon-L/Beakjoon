let N = Int(readLine()!)!

var link: [[Int]] = Array(repeating: [], count: N)
var result = Array(repeating: Array(repeating: "0", count: N), count: N)

for i in 0..<N {
  let y = readLine()!.split(separator: " ").map { Int($0)! }
  for j in 0..<y.count {
    if y[j] == 1 {
      link[i].append(j)
    }
  }
}

func dfs(start: Int, r: Int) {
  
  for i in link[start] {
    if result[r][i] != "1" {
      result[r][i] = "1"
      if i != r { dfs(start: i, r: r) }
    }
  }
}

for r in 0..<N {
  dfs(start: r, r: r)
}

for line in result {
    print(line.joined(separator: " "))
}
