let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
let n = nm[0]
let m = nm[1]

let numbers = Array(1...n)
var results = [[String]]()

makePermutation(start: 0, result: [])

func makePermutation(start index: Int, result: [String]) {
    if result.count == m {
        print(result.joined(separator: " "))
    }
    for i in index..<n {
        makePermutation(start: i + 1, result: result + ["\(numbers[i])"])

    }
}