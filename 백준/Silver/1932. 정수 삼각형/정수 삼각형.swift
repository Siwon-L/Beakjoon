import Foundation

func solution() {
    let n = Int(readLine()!)!
    var numberPyramid = [[0]]
    var dp = Array(repeating: Array(repeating: 0, count: n), count: n+1)
    for _ in 0..<n {
        let nums = readLine()!.split(separator: " ").compactMap { Int($0) }
        numberPyramid.append(nums)
    }

    dp[1][0] = numberPyramid[1][0]

    if n == 1 { print(dp[n].max()!); return }
    for i in 2...n {
        for j in 0..<numberPyramid[i].count {
            if j == 0 {
                dp[i][j] = dp[i-1][j] + numberPyramid[i][j]
            } else if j == numberPyramid[i].count - 1 {
                dp[i][j] = dp[i-1][j-1] + numberPyramid[i][j]
            } else {
                dp[i][j] = max(dp[i-1][j-1] + numberPyramid[i][j], dp[i-1][j] + numberPyramid[i][j])
            }
        }
    }

    print(dp[n].max()!)
}

solution()