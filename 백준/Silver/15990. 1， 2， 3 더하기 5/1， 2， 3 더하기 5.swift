import Foundation

func solution() {
    let max = 100000
    var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: 4)
, count: max + 1)
    dp[1] = [0,1,0,0]
    dp[2] = [0,0,1,0]
    dp[3] = [0,1,1,1]
    
    for i in 4...max {
        dp[i][1] = (dp[i-1][2] + dp[i-1][3]) % 1000000009
        dp[i][2] = (dp[i-2][1] + dp[i-2][3]) % 1000000009
        dp[i][3] = (dp[i-3][1] + dp[i-3][2]) % 1000000009
    }
    let t = Int(readLine()!)!
    for _ in 0..<t {
        let n = Int(readLine()!)!
        print(dp[n].reduce(0,+) % 1000000009 )
    }
}

solution()