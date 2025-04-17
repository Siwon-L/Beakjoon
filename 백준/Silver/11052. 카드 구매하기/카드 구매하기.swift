import Foundation

func solution(n: Int) {
    var p = [0]
    p += readLine()!.split(separator: " ").compactMap { Int($0) }
    var dp = p
    for i in 1...n {
        for j in 1..<i {
            dp[i] = max(dp[i], dp[i-j] + p[j])
        }
        
    }
    print(dp[n])
}

let n = Int(readLine()!)!
solution(n: n)