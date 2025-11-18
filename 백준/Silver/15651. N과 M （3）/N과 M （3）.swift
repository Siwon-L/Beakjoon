let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
let n = nm[0]
let m = nm[1]

let numbers = Array(1...n)

for number in numbers {
    makePermutation(result: ["\(number)"])
}


func makePermutation(result: [String]) {
    if result.count == m {
        print(result.joined(separator: " "))
        return
    }
    for i in 0..<n {
        makePermutation(result: result + ["\(numbers[i])"])
    }
}