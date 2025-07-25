import Foundation

func solution() {
    let n = Int(readLine()!)!
    var nums = readLine()!.split(separator: " ").compactMap { Int($0) }
    var dp = Array(repeating: 1, count: n)

    for i in 0..<n {
        for j in 0..<i {
            if nums[i] < nums[j] {
                dp[i] = max(dp[i], dp[j] + 1)
            }
        }
    }
    print(dp.max()!)
}

solution()