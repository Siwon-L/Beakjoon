
// 1 ≤ M, N ≤ 40,000
// 1 ≤ x ≤ M
// 1 ≤ y ≤ N

/// 최대공약수
func gcd(_ a: Int, _ b: Int) -> Int {
    if b == 0 {
        return a
    } else {
        return gcd(b, a % b)
    }
}

/// 최소공배수
func lcm(_ a: Int, _ b: Int) -> Int {
    return a * b / gcd(a, b)
}

let t = Int(readLine()!)!

for _ in 0..<t {
    let mnxy = readLine()!.split(separator: " ").compactMap { Int($0) }
    let m = mnxy[0]
    let n = mnxy[1]
    let x = mnxy[2]
    let y = mnxy[3]

    let maxYear = lcm(m,n)
    var result = -1
    for i in 0..<maxYear/m {
        let year = i * m + x
        let Y = year % n == 0 ? n : year % n

        if Y == y {
            result = year
            break
        }
    }
    print(result)
}