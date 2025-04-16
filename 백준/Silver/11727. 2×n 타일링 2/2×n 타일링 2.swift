import Foundation

func solution() {
    let n = Int(readLine()!)!
    var dp: [Int] = Array(repeating: 0, count: n + 1)

    if n > 2 {
        dp[1] = 1
        dp[2] = 3
        
        for i in 3...n {
            dp[i] = (dp[i-1] + 2 * dp[i-2]) % 10007
        }
        
        print(dp[n])
    } else if n == 2 {
        print(3)
    } else if n == 1 {
        print(1)
    }
}

solution()