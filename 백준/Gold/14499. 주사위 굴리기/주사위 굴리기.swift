import Foundation

struct Point {
  let y: Int
  let x: Int
}

let nmxyk = readLine()!.split(separator: " ").map { Int($0)! }
let n = nmxyk[0]
let m = nmxyk[1]
let y = nmxyk[2]
let x = nmxyk[3]
let k = nmxyk[4]
var map = [[Int]]()

for _ in 0..<n {
  let y = readLine()!.split(separator: " ").map({ Int($0)! })
  map.append(y)
}

var dice: [Int: Int] = [
  1: 0,
  2: 0,
  3: 0,
  4: 0,
  5: 0,
  6: 0
]

var dicPoint = Point(y: y,x: x)
let dy = [0, 0, 0, -1, 1]
let dx = [0, 1, -1, 0, 0]
for d in readLine()!.split(separator: " ").map({ Int($0)! }) {
  let nextPoint = Point(y: dicPoint.y + dy[d], x: dicPoint.x + dx[d])
  if (0..<n).contains(nextPoint.y) && (0..<m).contains(nextPoint.x) {
    dicPoint = nextPoint
    move(d)
    if map[nextPoint.y][nextPoint.x] != 0 {
      dice[6] = map[nextPoint.y][nextPoint.x]
      map[nextPoint.y][nextPoint.x] = 0
    } else {
      map[nextPoint.y][nextPoint.x] = dice[6]!
    }
    print(dice[1]!)
  }
}
func move(_ d: Int) {
  var temp = dice[1]!
  let arr: [Int]
  
  switch d {
  case 1: arr = [3,6,4,1]
  case 2: arr = [4,6,3,1]
  case 3: arr = [2,6,5,1]
  case 4: arr = [5,6,2,1]
  default: return
  }
  
  for i in arr {
    let c = dice[i]!
    dice[i] = temp
    temp = c
  }
}