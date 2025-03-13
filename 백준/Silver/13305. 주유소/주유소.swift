import Foundation

func solution() {
   let n = Int(readLine()!)!
   let distances = readLine()!.split(separator: " ").compactMap { Int($0) }
   let prices = readLine()!.split(separator: " ").compactMap { Int($0) }
   
   var result = 0
   var minPrice = prices[0]

   for i in 0..<n-1 {
      minPrice = min(minPrice, prices[i])
      result += minPrice * distances[i]
   }
   print(result)
   
}

solution()
