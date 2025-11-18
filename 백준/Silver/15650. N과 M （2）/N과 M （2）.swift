let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
let n = nm[0]
let m = nm[1]

let numbers = Array(1...n)
var visited = Array(repeating: false, count: n)
var results = [[String]]()

makePermutation(result: [])

results = results.map {
    return $0.sorted(by: <)
}

Set(results).sorted {
    let frist = $0.joined(separator: "")
    let secend = $1.joined(separator: "")
    return frist < secend
}.forEach {
    print($0.joined(separator: " "))
}

func makePermutation(result: [String]) {
    if result.count == m {
        results.append(result)
    }
    for i in 0..<n {
        if !visited[i] {
            visited[i] = true
            makePermutation(result: result + ["\(numbers[i])"])
            visited[i] = false
        }
    }
}