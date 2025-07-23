import Foundation

func solution() {
    let n = Int(readLine()!)!
    var dp = Array(repeating: 0, count: n+1)
    var wines = [0]
    for _ in 0..<n {
        let wine = Int(readLine()!)!
        wines.append(wine)
    }

    if n == 1 {
        print(wines[1]); return
    } else if n == 2 {
        print(wines[1] + wines[2]); return
    }

    dp[1] = wines[1]
    dp[2] = dp[1] + wines[2]

    for i in 3...n {
        dp[i] = max(dp[i-1], dp[i-2] + wines[i], dp[i-3] + wines[i] + wines[i-1])
    }
    print(dp[n])
}

solution()