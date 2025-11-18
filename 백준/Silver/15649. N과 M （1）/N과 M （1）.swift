let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
let n = nm[0]
let m = nm[1]

let numbers = Array(1...n)
var visited = Array(repeating: false, count: n)
var results = [[Int]]()

makePermutation(result: [])

results.forEach {
    $0.forEach { number in
        print(number, terminator: " ")
    }
    print("")
}

func makePermutation(result: [Int]) {
    if result.count == m {
        results.append(result)
    }
    for i in 0..<n {
        if !visited[i] {
            visited[i] = true
            makePermutation(result: result + [numbers[i]])
            visited[i] = false
        }
    }
}
