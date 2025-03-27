func solution() {
    let nk = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = nk[0]
    var k = nk[1]
    var nums = readLine()!.compactMap { Int(String($0)) }
    var results = [Int]()
    var leftover = [Int]()
    results.append(nums[0])
    for i in 1..<n {
        guard k > 0 else { leftover = Array(nums[i...]); break }
        while let last = results.last, last < nums[i], k > 0 {
            results.removeLast()
            k -= 1
        }
        results.append(nums[i])
    }
    results += leftover
    while k > 0 {
        results.removeLast()
        k -= 1
    }
    print(results.map { String($0) }.joined())
}

solution()
