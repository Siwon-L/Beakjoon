//
//  main.swift
//  CodingTest
//
//  Created by 이시원 on 10/20/24.
//

import Foundation

let n = Int(readLine()!)!
var visited = Array(repeating: false, count: 10)
let m = Int(readLine()!)!

if m != 0 {
  for i in readLine()!.split(separator: " ").map({ Int($0)! }) {
    visited[i] = true
  }
}

var result = abs(100 - n)

for channel in 0...1000000 {
  let pressNumberCount = pressNumberCount(channel)
  if pressNumberCount > 0 {
    let pressUpOrDownCount = abs(channel - n)
    result = min(result, pressUpOrDownCount + pressNumberCount)
  }
}

func pressNumberCount(_ channel: Int) -> Int {
  if channel == 0 {
    if visited[0] {
      return 0
    } else {
      return 1
    }
  }
  
  var count = 0
  var channel = channel
  
  while channel > 0 {
    if visited[channel % 10] {
      return 0
    }
    channel /= 10
    count += 1
  }
  return count
}

print(result)
