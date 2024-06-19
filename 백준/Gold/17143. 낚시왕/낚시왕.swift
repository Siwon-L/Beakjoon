let input = readLine()!.split(separator: " ").map { Int($0)! }
let Y = input[0]
let X = input[1]
let M = input[2]

class Shark {
  var y: Int
  var x: Int
  let speed: Int
  var d: Int
  let size: Int
  var isDeath = false
  var point: Int {
    return y * 1000 + x
  }
  
  init(y: Int, x: Int, speed: Int, d: Int, size: Int, isDeath: Bool = false) {
    self.y = y
    self.x = x
    self.speed = speed
    self.d = d
    self.size = size
    self.isDeath = isDeath
  }
}

var sharks = [Shark]()
var man = 0
var result = 0
for _ in 0..<M {
  let input = readLine()!.split(separator: " ").map { Int($0)! }
  sharks.append(Shark(
    y: input[0],
    x: input[1],
    speed: input[2],
    d: input[3],
    size: input[4]
  ))
}

for _ in 0..<X {
  man += 1
  catchShark()
  moveSharks()
}

func catchShark() {
  var target: Shark?
  
  for shark in sharks {
    guard shark.x == man && !shark.isDeath else  { continue }
    
    if target == nil {
      target = shark
    } else {
      target = target!.y < shark.y ? target : shark
    }
  }
  if target != nil {
    result += target!.size
    target?.isDeath = true
  }
  
}

func moveSharks() {
  var dic = [Int:Shark]()
  sharks.forEach { shark in
    if shark.isDeath { return }
    switch shark.d {
    case 1:
      let speed = shark.speed % ((Y - 1) * 2)
      if shark.y - speed < 1 {
        shark.d = 2
        let speed = abs(shark.y - speed - 1)
        if 1 + speed > Y {
          shark.d = 1
          shark.y = Y - abs(1 + speed - Y)
        } else {
          shark.y = 1 + speed
        }
      } else {
        shark.y -= speed
      }
    case 2:
      let speed = shark.speed % ((Y - 1) * 2)
      if shark.y + speed > Y {
        shark.d = 1
        let speed = abs(shark.y + speed - Y)
        if Y - speed < 1 {
          shark.d = 2
          shark.y = 1 + abs(Y - speed - 1)
        } else {
          shark.y = Y - speed
        }
      } else {
        shark.y += speed
      }
    case 3:
      let speed = shark.speed % ((X - 1) * 2)
      if shark.x + speed > X {
        shark.d = 4
        let speed = abs(shark.x + speed - X)
        if X - speed < 1 {
          shark.d = 3
          shark.x = 1 + abs(X - speed - 1)
        } else {
          shark.x = X - speed
        }
      } else {
        shark.x += speed
      }
    case 4:
      let speed = shark.speed % ((X - 1) * 2)
      if shark.x - speed < 1 {
        shark.d = 3
        let speed = abs(shark.x - speed - 1)
        if 1 + speed > X {
          shark.d = 4
          shark.x = X - abs(1 + speed - X)
        } else {
          shark.x = 1 + speed
        }
      } else {
        shark.x -= speed
      }
    default: break
    }
    if let existingShark = dic[shark.point] {
      if existingShark.size > shark.size {
        shark.isDeath = true
      } else {
        existingShark.isDeath = true
        dic[shark.point] = shark
      }
    } else {
      dic[shark.point] = shark
    }
  }
}

print(result)
