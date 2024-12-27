import Foundation

let n = Int(readLine()!)!
var results: [Int] = []

func isPrime(num: Int) -> Bool {
  if num < 2 { return false }
  for i in 2..<Int(sqrt(Double(num)) + 1) {
    if num % i == 0 { return false }
  }
  return true
}

func x(num: Int, size: Int) {
  if size == n {
    results.append(num)
    return
  }
  for i in [1,3,5,7,9] {
    let next = num * 10 + i
    if isPrime(num: next) {
      x(num: next, size: size + 1)
    }
  }
}

x(num: 2, size: 1)
x(num: 3, size: 1)
x(num: 5, size: 1)
x(num: 7, size: 1)

results.forEach { print($0) }
