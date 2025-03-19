import Foundation

func solution() {
   let nk = readLine()!.split(separator: " ").compactMap { Int($0) }
   let n = nk[0]
   let k = nk[1]
   let kinds = readLine()!.split(separator: " ").compactMap { Int($0) }.sorted()
   var diffs = [Int]()
   if k >= n {print(0); return}
   for i in 1..<n {
    let diff = kinds[i] - kinds[i - 1]
    diffs.append(diff)
   }
   diffs.sort()
   for _ in 0..<k-1 {
    diffs.removeLast()
   }
   print(diffs.reduce(0, +))
}

solution()
