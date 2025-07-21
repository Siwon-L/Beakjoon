import Foundation

func solution() {
    let n = Int(readLine()!)!
    var dp = Array(repeating: Array(repeating: 0, count: 10), count: n+1)

    for i in 0..<10 {
        dp[1][i] = 1
    }

    if n == 1 { print(dp[1].reduce(0,+)); return }

    for i in 2...n {
        for j in 0...9 {
            for k in 0...j {
                dp[i][j] += dp[i-1][k] % 10007
            }
        }
    }

    print((dp[n].reduce(0,+)) % 10007)
}

solution()