import Foundation

func solution() {
    let n = Int(readLine()!)!

    var dp = Array(repeating: Array(repeating: 0, count: 10), count: n+1)

    for i in 1...9 {
        dp[1][i] = 1
    }

    if n == 1 {
        print(dp[1].reduce(0,+))
        return
    }

    for i in 2...n {
        dp[i][0] = dp[i-1][1] % 1_000_000_000
        for j in 1...8 {
            dp[i][j] = (dp[i-1][j-1] % 1_000_000_000) + (dp[i-1][j+1] % 1_000_000_000)
        }
        dp[i][9] = dp[i-1][8] % 1_000_000_000
    }

    print(dp[n].reduce(0,+) % 1_000_000_000)
}

solution()