let N = Int(readLine()!)!
var input: [[String]] = []
var map: [[String]] = []
var result = 0

for _ in 0..<N {
  let y = Array(readLine()!).map { String($0) }
  input.append(y)
}


for y in 0..<N {
  for x in 0..<N {
    if (0..<N).contains(x+1) {
      map = input
      let t = map[y][x]
      map[y][x] = map[y][x+1]
      map[y][x+1] = t
      result = max(result, hori(y: y))
      result = max(result, ver(x: x))
      result = max(result, ver(x: x+1))
    }
    
    if (0..<N).contains(y+1) {
      map = input
      let t = map[y][x]
      map[y][x] = map[y+1][x]
      map[y+1][x] = t
      result = max(result, hori(y: y))
      result = max(result, hori(y: y+1))
      result = max(result, ver(x: x))
    }
  }
}
print(result)


func hori(y: Int) -> Int {
  var value = 0
  var target = ""
  var count = 1
  for x in 0..<N {
    if map[y][x] == target {
      count += 1
    } else {
      target = map[y][x]
      value = max(value, count)
      count = 1
    }
  }
  value = max(value, count)
  return value
}

func ver(x: Int) -> Int {
  var value = 0
  var target = ""
  var count = 1
  for y in 0..<N {
    if map[y][x] == target {
      count += 1
    } else {
      target = map[y][x]
      value = max(value, count)
      count = 1
    }
  }
  value = max(value, count)
  return value
}
