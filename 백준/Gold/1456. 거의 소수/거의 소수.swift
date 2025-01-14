import Foundation



func makePrimes() -> [Bool] {
  let limit = 10_000_000
  var primes = Array(repeating: true, count: limit + 1)
  primes[0...1] = [false, false]
  
  for i in 2...Int(sqrt(Double(limit))) + 1 {
    if primes[i] {
      var j = i * 2
      
      while j <= limit {
        primes[j] = false
        j += i
      }
    }
  }
  
  return primes
}

func calculate(num: Int, min: Double, max: Double, count: inout Int) {
  let left = Int(log(max, base: Double(num)))
  var right = Int(log(min, base: Double(num)))
  right = right < 2 ? 2 : right
  if left >= right, (min...max) ~= pow(Double(num), Double(left)) {
    if pow(Double(num), Double(right)) < min { right += 1 }
    count += left - right + 1
  }
}

func log(_ value: Double, base: Double) -> Double {
    return log(value) / log(base)
}

func solution() -> Int {
  let ab = readLine()!.split(separator: " ").map {Double($0)!}
  let (a,b) = (ab[0], ab[1])
  
  let primes = makePrimes().enumerated().filter { $0.element }.map(\.offset)
  var cnt = 0
  
  for prime in primes {
    calculate(num: prime, min: a, max: b, count: &cnt)
  }
  
  return cnt
}

print(solution())

