import Foundation

var n = Int(readLine()!)!
let primes = makeprime().enumerated().filter(\.element).map(\.offset)

var phi = n

for prime in primes {
  if n % prime == 0 {
    phi = phi / prime * (prime - 1)
  }
  
  while n % prime == 0 {
    n /= prime
  }
}

if n != 1 {
  phi = phi / n * (n - 1)
}

print(phi)

func makeprime() -> [Bool] {
  let limit = Int(sqrt(Double(n)) + 1)
  var isPrime = Array(repeating: true, count: limit)
  isPrime[0...1] = [false, false]
  
  for i in 2..<limit {
    if isPrime[i] {
      var j = 2
      while i * j < limit {
        isPrime[i * j] = false
        j += 1
      }
    }
  }
  return isPrime
}
