import Foundation

func solution() {
    let n = Int(readLine()!)!
    let nums: [Int] = [0] + readLine()!.split(separator: " ").compactMap { Int($0) }
    var dp: [Int] = Array(repeating: 1, count: n+1)

    for i in 1...n {
        for j in 1...i {
            if nums[j] < nums[i] {
                dp[i] = max(dp[i], dp[j]+1)
            }
        }
    }   

    print(dp.max()!)
}

solution()