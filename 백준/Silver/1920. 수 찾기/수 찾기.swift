let _ = Int(readLine()!)!
var dic = [Int: Bool]()
var r = [String]()
readLine()!.split(separator: " ").forEach({
    dic[Int($0)!] = true
})
let _ = Int(readLine()!)!
readLine()!.split(separator: " ").forEach {
    if dic[Int($0)!] == nil {
        r.append("0")
    } else {
        r.append("1")
    }
}
print(r.joined(separator: "\n"))