let N = Int(readLine()!)!
let signs = readLine()!.map { String($0) }

var S: [[String]] = Array(repeating: Array(repeating: "", count: N + 1), count: N + 1)
var result = [0]
var isFinished = false

setMatrix()
findResult(1)

func findResult(_ offset: Int) {
    if offset > N {
        isFinished = true
        print(result[1..<result.count].map { String($0) }.joined(separator: " "))
        return
    }

    for num in -10...10 {
        if isFinished { break }

        result.append(num)
        if isChecked(offset) {
            findResult(offset + 1)
        }
        result.removeLast()
    }
}

func isChecked(_ y: Int) -> Bool {
    var sum = 0
    for x in (1...y).reversed() {
        sum += result[x]

        if S[x][y] == "+" && sum <= 0 { return false }
        if S[x][y] == "-" && sum >= 0 { return false }
        if S[x][y] == "0" && sum != 0 { return false }
    }

    return true
}

func setMatrix() {
    var offset = 0

    for i in 1...N {
        for j in i...N {
            S[i][j] = signs[offset]
            offset += 1
        }
    }
}