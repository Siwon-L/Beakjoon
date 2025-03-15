import Foundation

struct Meeting {
  let start: Int
  let end: Int
}

let n = Int(readLine()!)!
var meetings = [Meeting]()

for _ in 0..<n {
  let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
  let meeting = Meeting(start: input[0], end: input[1])
  meetings.append(meeting)
}

var result = 1

meetings.sort {
  if $0.end < $1.end {
    return true
  } else if $0.end == $1.end {
    if $0.start < $1.start {
      return true
    }
  }
  return false
}
var temp = meetings[0]

for i in 1..<meetings.count {
  if meetings[i].start >= temp.end {
    temp = meetings[i]
    result += 1
  }
}

print(result)
