import Foundation

func solution() {
   let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
   let n = nm[0]
   let m = nm[1]

   var A = [[Int]]()

   for _ in 0..<n {
       let input = readLine()!.compactMap { Int(String($0)) }
       A.append(input)
   }

   var B = [[Int]]()

   for _ in 0..<n {
       let input = readLine()!.compactMap { Int(String($0)) }
       B.append(input)
   }

    if n < 3 || m < 3 {
        if A != B {
            print(-1); return
        } else {
            print(0); return
        }

    }
   var result = 0
   
    for i in 0...n-3 {
        for j in 0...m-3 {
           if A[i][j] != B[i][j] {
            reverse(y: i, x: j)
            result += 1
           }
           if A == B {
            break
           }
        }
        if A == B {
            break
        }
    }
   print(A == B ? result : -1)

   func reverse(y: Int, x: Int) {
        for i in y..<y+3 {
            for j in x..<x+3 {
                A[i][j] = A[i][j] == 1 ? 0 : 1
            }
        }
   }
}

solution()
