import Foundation

func solution() {
    let n = Int(readLine()!)!
    var nums = readLine()!.split(separator: " ").compactMap { Int($0) }
    nums.insert(0, at: 0)
    var dp = Array(repeating: 0, count: n+1)

    for i in 1...n {
        dp[i] = nums[i]
        for j in 1...i {
            if nums[i] > nums[j] {
                dp[i] = max(dp[i], dp[j] + nums[i])
            }
        }
    }
    print(dp.max()!)
}

solution()