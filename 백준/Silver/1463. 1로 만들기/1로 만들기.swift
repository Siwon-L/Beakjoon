import Foundation

func solution() {
    let x = Int(readLine()!)!

    if x == 1 {
        print(0)
    } else if x == 2 {
        print(1)
    } else if x == 3 {
        print(1)
    } else {
        var dp = [Int](repeating: 0, count: x + 1)
        dp[1] = 0
        dp[2] = 1
        dp[3] = 1
        
        for i in 4...x {
            dp[i] = dp[i-1] + 1
            if i % 2 == 0 {
                dp[i] = min(dp[i], dp[i/2] + 1)
            }
            if i % 3 == 0 {
                dp[i] = min(dp[i], dp[i/3] + 1)
            }
        }
        print(dp[x])
    }
}

solution()