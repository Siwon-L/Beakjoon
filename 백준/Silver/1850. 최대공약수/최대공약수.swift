import Foundation

let ab = readLine()!.split(separator: " ").map { UInt($0)! }.sorted(by: >)
let a = ab[0]
let b = ab[1]

let result = gcd(large: a, small: b)
let x = Array(repeating: "1", count: Int(result)).joined()
print(x)

func gcd(large: UInt, small: UInt) -> UInt {
  return small == 0 ? large : gcd(large: small, small: large % small)
}
