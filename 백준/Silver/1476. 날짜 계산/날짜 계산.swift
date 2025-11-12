// 1 ≤ E ≤ 15
// 1 ≤ S ≤ 28
// 1 ≤ M ≤ 19

enum YearType {
    case E
    case S
    case M
} 

let esm = readLine()!.split(separator: " ").compactMap { Int($0) }

let es = xx(type: .E, value: esm[0])
let ss = xx(type: .S, value: esm[1])
let ms = xx(type: .M, value: esm[2])

print(es.intersection(ss).intersection(ms).sorted(by: <)[0])


func xx (type: YearType, value: Int) -> Set<Int> {
    var list: Set<Int> = [value]
    var newValue = value
    while newValue <= 7980 {
        switch type {
            case .E:
                newValue += 15
                list.insert(newValue)
            case .S:
                newValue += 28
                list.insert(newValue)
            case .M:
                newValue += 19
                list.insert(newValue)
        }
    }
    return list
}