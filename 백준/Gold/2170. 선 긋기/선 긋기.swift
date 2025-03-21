struct Line {
    let start: Int
    let end: Int

    func length(_ stratPoint: Int?) -> Int {
        if let stratPoint = stratPoint {
            return self.end - stratPoint
        } else {
            return self.end - self.start
        }
    }
}

import Foundation

final class FileIO {
private let buffer: Data
private var index: Int = 0

init(fileHandle: FileHandle = FileHandle.standardInput) {
    self.buffer = try! fileHandle.readToEnd()! // 인덱스 범위 넘어가는 것 방지
}

@inline(__always) private func read() -> UInt8 {
    defer {
        index += 1
    }
    guard index < buffer.count else { return 0 }
    
    return buffer[index]
}

@inline(__always) func readInt() -> Int {
var sum = 0
var now = read()
var isPositive = true
    while now == 10
            || now == 32 { now = read() } // 공백과 줄바꿈 무시
    if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
    while now >= 48, now <= 57 {
        sum = sum * 10 + Int(now-48)
        now = read()
    }
    return sum * (isPositive ? 1:-1)
}

@inline(__always) func readString() -> String {
        var str = ""
        var now = read()

        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시

        while now != 10
                && now != 32 && now != 0 {
            str += String(bytes: [now], encoding: .ascii)!
            now = read()
        }

        return str
    }
}

func solution() {
    let fileIO = FileIO()
    let n = fileIO.readInt()
    var lines = [Line]()
    for _ in 0..<n {
        let s = fileIO.readInt()
        let e = fileIO.readInt()
        let line = Line(start: s, end: e)
        lines.append(line)
    }
    lines.sort {
        if $0.start < $1.start {
            return true
        } else if $0.start == $1.start, $0.end < $1.end {
            return true
        }
        return false
    }
    var result = 0
    var point = Int.min
    for line in lines {
        if point < line.start {
            result += line.length(nil)
            point = line.end
        } else {
            if point >= line.end {
                continue
            } else {
                result += line.length(point)
                point = line.end
            }
        }
    }
    print(result)
}

solution()