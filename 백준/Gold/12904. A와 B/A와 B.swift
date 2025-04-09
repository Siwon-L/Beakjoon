func solution() {
    let s = readLine()!.map { String($0) }
    var t = readLine()!.map { String($0) }
    
    while t.count > s.count {
        if t.last! == "A" {
            t.removeLast()
        } else {
            t.removeLast()
            t.reverse()
        }
    }
    if t == s {
        print(1)
    } else {
        print(0)
    }
    
}


solution()