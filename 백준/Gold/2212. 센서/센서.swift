import Foundation

func solution() {
    let n = Int(readLine()!)!
    let k = Int(readLine()!)!
    let sensors = Set(readLine()!.split(separator: " ").compactMap { Int($0) }).sorted()

    if k >= n { print(0); return }

    var diffs = [Int]()
    for i in 1..<sensors.count {
        let diff = sensors[i] - sensors[i-1]
        diffs.append(diff)
    }
    diffs.sort()
    var result = 0
    for i in 0...diffs.count - k {
        result += diffs[i]
    }
    print(result)
}

solution()
