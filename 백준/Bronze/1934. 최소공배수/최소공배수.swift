import Foundation

let t = Int(readLine()!)!

for _ in 0..<t {
  let ab = readLine()!.split(separator: " ").map { Int($0)! }.sorted(by: >)
  let a = ab[0]
  let b = ab[1]
  
  let gcd = gcd(large: a, small: b)
  print(a * b / gcd)
}


func gcd(large: Int, small: Int) -> Int {
  return small == 0 ? large : gcd(large: small, small: large % small)
}
