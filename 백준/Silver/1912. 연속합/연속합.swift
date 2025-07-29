import Foundation

func solution() {
    let n = Int(readLine()!)!
    let nums = readLine()!.split(separator: " ").compactMap { Int($0) }

    if n == 1 { print(nums[0]); return }

    var dp = Array(repeating: 0, count: n)
    dp[0] = nums[0]

    for i in 1..<n {
        dp[i] = max(dp[i-1] + nums[i], nums[i])
    }

    print(dp.max()!)
}

solution()