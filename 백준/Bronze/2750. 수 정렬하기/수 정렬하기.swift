import Foundation

var arr = [Int]()
let n = Int(readLine()!)!

for _ in 1...n {
  let num = Int(readLine()!)!
  arr.append(num)
}

quickSort(arr).forEach { print($0) }

func quickSort(_ arr: [Int]) -> [Int] {
  guard arr.count > 1 else { return arr }
  let pivot = arr[0]
  let left = arr.filter { $0 < pivot }
  let right = arr.filter { $0 > pivot }
  return quickSort(left) + [pivot] + quickSort(right)
}

