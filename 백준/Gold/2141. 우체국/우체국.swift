func solution() {
    let n = Int(readLine()!)!
    var villages = [(location: Int, peoples: Int)]()
    var totalPeoples = 0
    for _ in 0..<n {
        let input = readLine()!.split(separator: " ").compactMap { Int($0) }
        villages.append((input[0], input[1]))
        totalPeoples += input[1]
    }
    villages.sort { $0.location < $1.location }
    let half = (totalPeoples + 1) / 2
    var cumulative = 0
    for village in villages {
        cumulative += village.peoples
        if cumulative >= half {
            print(village.location)
            return
        }
    }
}

solution()