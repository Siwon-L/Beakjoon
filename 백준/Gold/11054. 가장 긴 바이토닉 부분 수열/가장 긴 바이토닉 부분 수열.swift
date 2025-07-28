import Foundation

func solution() {
    let n = Int(readLine()!)!
    var nums = readLine()!.split(separator: " ").compactMap { Int($0) }
    var dp = Array(repeating: 1, count: n)
    var dp1 = Array(repeating: 1, count: n)
    for i in 0..<n {
        for j in 0..<i {
            if nums[i] > nums[j] {
                dp[i] = max(dp[i], dp[j] + 1)
            }
        }
    }

    for i in stride(from: n-1, through: 0, by: -1) {
        for j in stride(from: n-1, to: i, by: -1) {
            if nums[i] > nums[j] {
                dp1[i] = max(dp1[i], dp1[j] + 1)
            }
        }
    }

    print(dp.enumerated().map { i, v in v + dp1[i] - 1 }.max()!)
}

solution()