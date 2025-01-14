import Foundation

var n = Int(readLine()!)!

while true {
  if isPrime(num: n) {
    let reversed = Array(String(n)).reversed().map { String($0) }.joined()
    if n == Int(reversed)! {
      print(n)
      break
    }
  }
  n += 1
}

func isPrime(num: Int) -> Bool {
  if num < 2 { return false }
  for i in 2..<Int(sqrt(Double(num)) + 1) {
    if num % i == 0 { return false }
  }
  return true
}
