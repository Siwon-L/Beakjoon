import Foundation

func solution() {
    let n = Int(readLine()!)!
    var dp = Array(repeating: [Int](), count: 30+1)
    dp[2] = [3]
    dp[4] = [9,2]
    if n < 6 { print(dp[n].reduce(0,+)); return }

    for i in 6...n {
        guard i%2 == 0 else { continue }
        dp[i] += dp[i-2].map { $0 * 3 }
        for j in 4...(i-2) {
            guard j%2 == 0 else { continue }
            dp[i] += dp[i-j].map { $0 * 2 }
        }
       
        dp[i] += [2]
    }

    print(dp[n].reduce(0,+))
}
solution()