import Foundation

func solution() {
    let n = Int(readLine()!)!
    let nums = readLine()!.split(separator: " ").compactMap { Int($0) }
    
    if n == 1 { print(nums[0]); return }
    
    var dp_l = Array(repeating: 0, count: n)
    dp_l[0] = nums[0]
    var dp_r = Array(repeating: 0, count: n)
    dp_r[n-1] = nums.last!
    for i in 1..<n {
        dp_l[i] = max(dp_l[i-1] + nums[i], nums[i])   
    }
    var result = dp_l.max()!
    for i in stride(from: n-2, through: 0, by: -1) {
        dp_r[i] = max(dp_r[i+1] + nums[i], nums[i])   
    }

    for i in 1..<n-1 {
        let left = i - 1
        let right = i + 1
        result = max(result, dp_l[left] + dp_r[right])
    }

    print(result)
}

solution()