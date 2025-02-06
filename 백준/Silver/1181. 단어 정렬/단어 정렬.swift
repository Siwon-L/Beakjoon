let n = Int(readLine()!)!

var set = Set<String>()

for _ in 0..<n {
  let input = readLine()!
  set.insert(input)
}

set.sorted {
  if $0.count < $1.count {
    return true
  } else if $0.count == $1.count {
    return $0 < $1
  } else {
    return false
  }
}.forEach { print($0) }
