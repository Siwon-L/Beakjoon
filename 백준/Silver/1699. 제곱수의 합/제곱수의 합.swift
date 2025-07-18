import Foundation

func solution() {
    let n = Int(readLine()!)!
    var dp = Array(repeating: 0, count: n+1)

    for i in 1...n {
        dp[i] = i
        for j in 1...i {
            if i < j * j { break }
            dp[i] = min(dp[i], dp[i - j * j] + 1)
        }
    }

    print(dp[n])
}

solution()
