let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
let n = nm[0]
let m = nm[1]

var set = Set<String>()
for _ in 0..<n {
  let input = readLine()!
  set.insert(input)
}

var result = 0

for _ in 0..<m {
  let input = readLine()!
  if set.contains(input) {
    result += 1
  }
}

print(result)
