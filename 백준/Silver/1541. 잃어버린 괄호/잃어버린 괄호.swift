let plus = readLine()!.split(separator: "-")
var result = 0

for i in plus[0].split(separator: "+") {
    result += Int(i)!
}

for i in plus[1...] {
    for j in i.split(separator: "+") {
        result -= Int(j)!
    }
}

print(result)
