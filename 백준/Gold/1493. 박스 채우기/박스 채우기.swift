import Foundation

func solution() {
    let lwh = readLine()!.split(separator: " ").compactMap { Int($0) }
    let l = lwh[0], w = lwh[1], h = lwh[2]
    let n = Int(readLine()!)!
    var cubes = Array(repeating: 0, count: 20)
    for _ in 0..<n {
        let cube = readLine()!.split(separator: " ").compactMap { Int($0) }
        cubes[cube[0]] = cube[1]
    }
    var count = 0
    var isSuccese = true
    func putCube(in box: (l: Int, w: Int, h: Int), i: Int) {
        guard box.l * box.w * box.h != 0 else { return }
        for j in i..<20 {
            let cube = 19 - j
            if cubes[cube] == 0 { continue }
            let cubeLeng = Int(pow(2, Double(cube)))
            if box.l >= cubeLeng, box.w >= cubeLeng, box.h >= cubeLeng {
                count += 1
                cubes[cube] -= 1
                putCube(in: (box.l - cubeLeng, box.w, box.h), i: j)
                putCube(in: (cubeLeng, box.w - cubeLeng, box.h), i: j)
                putCube(in: (cubeLeng, cubeLeng, box.h - cubeLeng), i: j)
                return
            }
        }
        isSuccese = false
    }
    putCube(in: (l, w, h), i: 0)
    print(isSuccese ? count : -1)
}

solution()