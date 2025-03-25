func solution() {
    let nk = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = nk[0]
    let k = nk[1]

    let plugs = readLine()!.split(separator: " ").compactMap { Int($0) }

    var currents = Array<Int>()
    var count = 0
    var result = 0
    for (i, plug) in plugs.enumerated() {
        if count < n {
            if !currents.contains(plug) { 
                currents.append(plug)
                count += 1
            }
        } else {
            if !currents.contains(plug) {
                let x = currents.map { current in plugs[i...].firstIndex { $0 == current } ?? Int.max }
                let deleteIndex = x.firstIndex { $0 == x.max() }
                currents[deleteIndex!] = plug
                result += 1
            }
        }
    }
    print(result)
}

solution()