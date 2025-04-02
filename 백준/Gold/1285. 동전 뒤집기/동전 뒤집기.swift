func solution() {
    let n = Int(readLine()!)!
    var coins = [[String]]()
    for _ in 0..<n {
        let input = readLine()!.compactMap { String($0) }
        coins.append(input)
    }
    var result = Int.max

    dfs(0, currnet: coins)
    print(result)
    

    func dfs(_ row: Int, currnet coins: [[String]]) {
        if row == n {
            var sum = 0
            for col in 0..<n {
                var tCount = 0
                for row in 0..<n {
                    if coins[row][col] == "T" {
                        tCount += 1
                    }
                }
                sum += min(tCount, n - tCount) // 열을 뒤집었을 경우와 그렇지 않은 경우의 최소 T의 개수
            }
            result = min(result, sum)
            return
        }
        
        /// 뒤집지 않는 Case
        dfs(row + 1, currnet: coins) 

        /// 뒤집는 Case
        var reversedCoins = coins
        for col in 0..<n {
            reversedCoins[row][col] = reversedCoins[row][col] == "T" ? "H" : "T"
        }
        dfs(row + 1, currnet: reversedCoins)
    }
}

solution()
