import Foundation

let mans = Array(0..<9).map { _ in Int(readLine()!)! }

var result = [Int]()

combination(0, [])

result.sorted().forEach { print($0) }

func combination(_ index: Int, _ combi: [Int]) {
    if combi.count == 7 {
        if combi.reduce(0, +) == 100 {
            result = combi
        }
        return
    } 

    for i in index..<9 {
        combination(i+1, combi + [mans[i]])
    }
}