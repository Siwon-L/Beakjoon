import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)! }

let n = nm[0]
let m = nm[1]

for i in n...m {
  if i > 2, i % 2 == 0 {
    continue
  }
  if isPrime(num: i) { print(i) }
}

func isPrime(num: Int) -> Bool {
  if num < 2 { return false }
  for i in 2..<Int(sqrt(Double(num)) + 1) {
    if num % i == 0 { return false }
  }
  return true
}
