import Foundation

let n = Int(readLine()!)!
var counts = Array(repeating: 0, count: 10001)

for _ in 0..<n {
    let num = Int(readLine()!)!
    counts[num] += 1
}

var result = ""
for i in 1...10000 {
  result += String(repeating: "\(i)\n", count: counts[i])
}

print(result)
