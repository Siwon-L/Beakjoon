import Foundation

struct Point {
  let y: Int
  let x: Int
}

var input = readLine()!.split(separator: " ").map { Int($0)! }
let n = input[0]
let m = input[1]
input = readLine()!.split(separator: " ").map { Int($0)! }
let y = input[0]
let x = input[1]
var d = input[2]
var map = [[Int]]()
var visited = Array(repeating: Array(repeating: false, count: m), count: n)
for _ in 0..<n {
  input = readLine()!.split(separator: " ").map { Int($0)! }
  map.append(input)
}

@discardableResult
func dfs(_ point: Point, count: Int) -> Int {
  let dy = [-1,0,1,0]
  let dx = [0,1,0,-1]
  var newCount = count
  if !visited[point.y][point.x] {
    newCount += 1
    visited[point.y][point.x] = true
  }
  if isCleanable(point) { /// 3
    while true {
      d = d - 1 < 0 ? 3 : d - 1
      let newPoint = Point(y: point.y + dy[d], x: point.x + dx[d])
      if !visited[newPoint.y][newPoint.x] && map[newPoint.y][newPoint.x] != 1 {
        break
      }
    }
    return dfs(Point(y: point.y + dy[d], x: point.x + dx[d]), count: newCount)
  } else { /// 2
    let newPoint: Point
    switch d {
    case 0:
      newPoint = Point(y: point.y + dy[2], x: point.x + dx[2])
    case 1:
      newPoint = Point(y: point.y + dy[3], x: point.x + dx[3])
    case 2:
      newPoint = Point(y: point.y + dy[0], x: point.x + dx[0])
    case 3:
      newPoint = Point(y: point.y + dy[1], x: point.x + dx[1])
    default: return newCount
    }
    if map[newPoint.y][newPoint.x] == 1 {
      return newCount
    }
    return dfs(newPoint, count: newCount)
  }
}

func isCleanable(_ point: Point) -> Bool {
  let dy = [-1,0,1,0]
  let dx = [0,1,0,-1]
  
  for i in 0..<4 {
    let newPoint = Point(y: point.y + dy[i], x: point.x + dx[i])
    if !visited[newPoint.y][newPoint.x] && map[newPoint.y][newPoint.x] != 1 {
      return true
    }
  }
  return false
}

print(dfs(Point(y: y, x: x), count: 0))
