import Foundation

let minMax = readLine()!.split(separator: " ").map { Int($0)! }

let min = minMax[0]
let max = minMax[1]

var isNONO = Array(repeating: true, count: max - min + 1)

for i in 2..<Int(sqrt(Double(max)) + 1) {
  let pow = i * i
  var j = Int(ceil(Double(min) / Double(pow)))
  while pow * j <= max {
    isNONO[pow * j - min] = false
    j += 1
  }
}

print(isNONO.filter { $0 }.count)
