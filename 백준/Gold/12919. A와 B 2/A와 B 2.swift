func solution() {
    let s = readLine()!.map { String($0) }
    var t = readLine()!.map { String($0) }
    var isSuccese = false
    
    func run(_ t: [String]) {
        guard t.count > s.count else {
            if !isSuccese {
                isSuccese = s == t
            }
            return
        }
        if t.first == "B" {
            var newT = t
            newT.reverse()
            newT.removeLast()
            run(newT)
            if t.last == "A" {
                var newT = t
                newT.removeLast()
                run(newT)
            }
        } else if t.last == "A" {
            var newT = t
            newT.removeLast()
            run(newT)
        } else {
            if !isSuccese {
                isSuccese = s == t
            }
            return
        }
    }
    run(t)
    print(isSuccese ? 1 : 0)
}



solution()