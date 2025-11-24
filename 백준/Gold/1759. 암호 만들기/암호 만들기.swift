let lc = readLine()!.split(separator: " ").compactMap { Int($0) }
let l = lc[0]
let c = lc[1]
let vowels: Set<String> = ["a", "e", "i", "o", "u"]

let input = readLine()!.split(separator: " ").map { String($0) }.sorted(by: <)
makeSecret(start: 0, secret: [])

func makeSecret(start index: Int, secret: [String]) {
    if secret.count == l {
        let vowelCount = secret.filter { vowels.contains($0) }.count
        let consonantCount = l - vowelCount
        if vowelCount >= 1 && consonantCount >= 2 {
            print(secret.joined())
        }
        return
    }
    for i in index..<c {
        makeSecret(start: i+1, secret: secret + [input[i]])
    }
}