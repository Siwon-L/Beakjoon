import Foundation

func solution() {
    let n = Int(readLine()!)!
    var dp = Array(repeating: Array(repeating: 0, count: 2), count: n+1)

    dp[1][0] = 1
    dp[1][1] = 2

    if n == 1 { print(dp[1].reduce(0,+)); return }

    for i in 2...n {
        dp[i][0] = (dp[i-1][0] + dp[i-1][1]) % 9901
        dp[i][1] = (dp[i-1][0] * 3 + dp[i-1][1] * 2 - dp[i][0]) % 9901
    }

    print((dp[n].reduce(0,+)) % 9901)
}

solution()