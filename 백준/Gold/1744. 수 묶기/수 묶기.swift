import Foundation

let n = Int(readLine()!)!

var plus = [Int]()
var ones = [Int]()
var minus = [Int]()

for _ in 0..<n {
  let num = Int(readLine()!)!
  if num > 1 {
    plus.append(num)
  } else if num == 1 {
    ones.append(num)
  } else {
    minus.append(num)
  }
}

plus.sort(by: <)
minus.sort(by: >)

var result = 1 * ones.count

while !plus.isEmpty {
  guard plus.count >= 2 else {
    result += plus.removeLast()
    break
  }
  
  let left = plus.removeLast()
  let right = plus.removeLast()
  result += left * right
}

while !minus.isEmpty {
  guard minus.count >= 2 else {
    result += minus.removeLast()
    break
  }
  
  let left = minus.removeLast()
  let right = minus.removeLast()
  result += left * right
}

print(result)
