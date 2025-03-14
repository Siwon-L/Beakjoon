import Foundation

func solution() {
    let nl = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = nl[0]
    let l = nl[1]
    let distances = readLine()!.split(separator: " ").compactMap { Int($0) }.sorted(by: <)

    var result = 0
    var point: Int? = nil
    for distance in distances {
        if point != nil {
            let long = distance - point! + 1
            if long > l {
                result += 1
                point = distance
            }
        } else {
            point = distance
            result += 1
            continue
        }
    }
    print(result)
}

solution()
