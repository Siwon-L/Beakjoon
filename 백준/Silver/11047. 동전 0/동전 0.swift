let NK = readLine()!.split(separator: " ").map { Int($0)! }

let N = NK[0]
var K = NK[1]
var coins: [Int] = []
var result = 0

for _ in 0..<N {
  let coin = Int(readLine()!)!
  if coin > K { break }
  coins.append(coin)
}

for i in 0..<coins.count {
  let coin = coins[coins.count - (1 + i)]
  let count = K / coin
  result += count
  K -= count * coin
}

print(result)

