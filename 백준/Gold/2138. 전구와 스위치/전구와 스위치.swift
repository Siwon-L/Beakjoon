func solution() {
    let n = Int(readLine()!)!
    var lightBulbs = readLine()!.compactMap { Int(String($0)) }
    let target = readLine()!.compactMap { Int(String($0)) }

    if n < 3 {
        if lightBulbs == target {
            print(0)
        } else {
            pushSwitch(0, n: n, lightBulbs: &lightBulbs)
            if lightBulbs == target {
                print(1)
            } else {
                print(-1)
            }
        }
        return
    }
    
    var result = Int.max
    result = min(result, run(n: n, lightBulbs: lightBulbs, target: target, startCount: 0))
    pushSwitch(0, n: n, lightBulbs: &lightBulbs)
    result = min(result, run(n: n, lightBulbs: lightBulbs, target: target, startCount: 1))
    print(result == Int.max ? -1 : result)
}

func run(n: Int, lightBulbs: [Int], target: [Int], startCount: Int) -> Int {
    var count = startCount
    var lightBulbs = lightBulbs
    for i in 1..<n {
        if lightBulbs[i-1] != target[i-1] {
            count += 1
            pushSwitch(i, n: n, lightBulbs: &lightBulbs)
        }
    }
    if lightBulbs == target { return count }
    else { return Int.max }
}

func pushSwitch(_ i: Int, n: Int, lightBulbs: inout [Int]) {
    for j in [i-1, i, i+1] {
        if (0..<n) ~= j {
            lightBulbs[j] = lightBulbs[j] == 0 ? 1 : 0
        }
    }
}

solution()
