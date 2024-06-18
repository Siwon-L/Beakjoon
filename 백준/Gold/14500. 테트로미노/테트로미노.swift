import Foundation



let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0]
let m = nm[1]
var visited = Array(repeating: Array(repeating: false, count: m), count: n)
var map = [[Int]]()

for _ in 0..<n {
  let y = readLine()!.split(separator: " ").map { Int($0)! }
  map.append(y)
}

struct Point {
  let y: Int
  let x: Int
}

func dfs(_ start: Point, count: Int, sum: Int) {
  let dy = [-1, 0, 1, 0]
  let dx = [0, 1, 0, -1]
  let value = map[start.y][start.x]
  
  if count == 4 {
    maximum = max(maximum, value + sum)
    return
  }
  
  for i in 0..<4 {
    let next: Point = Point(y: start.y + dy[i], x: start.x + dx[i])
    if (0..<n).contains(next.y) &&
        (0..<m).contains(next.x) &&
        !visited[next.y][next.x] {
      visited[next.y][next.x] = true
      dfs(next, count: count + 1, sum: value + sum)
      visited[next.y][next.x] = false
    }
  }
}

func exception(_ point: Point) {
  guard (0..<n).contains(point.y + 1) && (0..<m).contains(point.x + 1) else { return }
  let (y, x) = (point.y, point.x)
  /// ㅗ, ㅜ
  if point.x - 1 >= 0 {
    maximum = max(
      maximum,
      max(
        map[y][x] + map[y+1][x] + map[y+1][x-1] + map[y+1][x+1],
        map[y][x] + map[y+1][x] + map[y][x-1] + map[y][x+1]
      )
    )
  }
  /// ㅏ, ㅓ
  if point.y - 1 >= 0 {
    maximum = max(
      maximum,
      max(
        map[y][x] + map[y-1][x] + map[y+1][x] + map[y][x+1],
        map[y][x] + map[y-1][x+1] + map[y][x+1] + map[y+1][x+1]
      )
    )
  }
}

var maximum = 0

for y in 0..<n {
  for x in 0..<m {
    visited[y][x] = true
    dfs(Point(y: y, x: x), count: 1, sum: 0)
    visited[y][x] = false
    exception(Point(y: y, x: x))
  }
}

print(maximum)

