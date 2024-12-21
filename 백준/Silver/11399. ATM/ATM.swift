import Foundation

var n = Int(readLine()!)!

var arr = readLine()!.split(separator: " ").map { Int($0)! }.sorted(by: <)
var sum = arr[0]

for i in 1..<n {
  sum += arr[0...i].reduce(0, +)
}

print(sum)


