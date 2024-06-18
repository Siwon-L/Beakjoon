let N = Int(readLine()!)!
var dp: [Int] = Array(repeating: 0, count: N + 2)

for i in 1...N {
  let TP = readLine()!.split(separator: " ").map { Int($0)! }
  
  if i+TP[0] > N + 1 { continue }
  
  dp[i + TP[0]] = max(TP[1] + dp[1...i].max()!, dp[i + TP[0]])
}

print(dp.max()!)
