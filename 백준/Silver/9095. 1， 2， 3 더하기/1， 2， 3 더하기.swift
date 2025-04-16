import Foundation

func solution(n: Int) {
    var dp: [Int] = Array(repeating: 0, count: n + 1)

    if n > 3 {
        dp[1] = 1
        dp[2] = 2
        dp[3] = 4
        
        for i in 4...n {
            dp[i] = dp[i-1] + dp[i-2] + dp[i-3]
        }
        
        print(dp[n])
    } else if n == 3 {
        print(4)
    } else if n == 2 {
        print(2)
    } else if n == 1 {
        print(1)
    }
}

let t = Int(readLine()!)!

for _ in 0..<t {
    let n = Int(readLine()!)!
    solution(n: n)
}