import Foundation

let nm = readLine()!.split(separator: " ").map { Double($0)! }

let a = nm[0] < 2 ? 2 : nm[0]
let b = nm[1]

let limit = Int(sqrt(Double(b)))

var isPrimeNubers = Array(repeating: true, count: limit + 1)

var count = 0

for i in 2..<Int(sqrt(Double(limit)) + 1) {
  if isPrimeNubers[i] {
    var j = 2
    while i * j <= limit {
      isPrimeNubers[i * j] = false
      j += 1
    }
  }
}

for i in 1...limit {
  if i < 2 { continue }
  if isPrimeNubers[i] {
    calculate(num: i, min: a, max: b)
  }
}

print(count)

func calculate(num: Int, min: Double, max: Double) {
  let left = Int(log(max, base: Double(num)))
  var right = Int(log(min, base: Double(num)))
  right = right < 2 ? 2 : right
  if (min...max) ~= pow(Double(num), Double(left)) {
    if pow(Double(num), Double(right)) < min { right += 1 }
    count += left - right + 1
  }
}

func log(_ value: Double, base: Double) -> Double {
    return log(value) / log(base)
}
