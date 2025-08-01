import Foundation

func solution() {
    let n = Int(readLine()!)!
    let MAX = 1000 * 1000 + 1
    var colors = Array(repeating: [0,0,0], count: n+1)
    for i in 1...n {
        let color = readLine()!.split(separator: " ").compactMap { Int($0) }
        colors[i] = color
    }
    var result = MAX
    var dp = Array(repeating: [0,0,0], count: n+1)

    for j in 0..<3 {
        let a = (j+1)%3
        let b = (j+2)%3

        dp[1][j] = colors[1][j]
        dp[1][a] = MAX
        dp[1][b] = MAX

        for i in 2...n {
            dp[i][0] = min(dp[i-1][1], dp[i-1][2]) + colors[i][0]
            dp[i][1] = min(dp[i-1][0], dp[i-1][2]) + colors[i][1]
            dp[i][2] = min(dp[i-1][0], dp[i-1][1]) + colors[i][2]
        }
        result = min(result, dp[n][a], dp[n][b])
    }

    print(result)
}
solution()