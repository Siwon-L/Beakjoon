func solution() {
    let nk = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = nk[0]
    var k = nk[1]
    
    var result = ""
    var aCount = 0
    for i in 0..<n {
        if k > 0, k >= n - (i + 1) - aCount {
            result += "A"
            k -= n - (i + 1) - aCount
            aCount += 1
            
        } else {
            result += "B"
        }
    }
    print(result.contains("B") ? result : -1)
}

solution()