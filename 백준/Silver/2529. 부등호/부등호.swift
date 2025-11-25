let k = Int(readLine()!)!
let signs = readLine()!.split(separator: " ").map { String($0) }
var visited = Array(repeating: false, count: 10)

var results = [String]()
makePermutation(signIndex: -1, before: nil, result: [])

print(results.max()!)
print(results.min()!)

func makePermutation(signIndex: Int, before: Int?, result: [String]) {
    if result.count == k + 1 {
        let value = result.joined()
        results.append(value)
        return
    }

    for i in 0...9 {
        if !visited[i] {
            if let before = before {
                if signs[signIndex] == "<", before < i {
                    visited[i] = true
                    makePermutation(signIndex: signIndex + 1, before: i, result: result + ["\(i)"])
                    visited[i] = false
                }

                if signs[signIndex] == ">", before > i {
                    visited[i] = true
                    makePermutation(signIndex: signIndex + 1, before: i, result: result + ["\(i)"])
                    visited[i] = false
                }
            } else {
                visited[i] = true
                makePermutation(signIndex: signIndex + 1, before: i, result: result + ["\(i)"])
                visited[i] = false
            }
        }
    }
}