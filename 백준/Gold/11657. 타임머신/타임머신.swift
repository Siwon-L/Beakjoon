let nm = readLine()!.split(separator: " ").map { Int($0)! }

let n = nm[0]
let m = nm[1]

let intMax = 64321654

var links = [(s: Int, e: Int, l: Int)]()

for _ in 0..<m {
  let sel = readLine()!.split(separator: " ").map { Int($0)! }
  links.append((s: sel[0], e: sel[1], l: sel[2]))
}

var dist: [Int] = Array(repeating: intMax, count: n + 1)
dist[1] = 0

for _ in 0..<n-1 {
  for link in links where dist[link.s] != intMax {
    dist[link.e] = min(dist[link.e], dist[link.s] + link.l)
  }
}

var isNegativeCycle = false

for link in links where dist[link.s] != intMax {
  if dist[link.e] > dist[link.s] + link.l {
    isNegativeCycle = true
  }
}

if isNegativeCycle {
  print(-1)
} else {
  dist[2...].forEach {
    print($0 == intMax ? -1 : $0)
  }
}
