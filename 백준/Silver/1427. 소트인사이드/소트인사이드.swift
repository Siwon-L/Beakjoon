import Foundation

var arr = readLine()!.map { Int(String($0))! }


print(arr.sorted(by: >).map {String($0)}.joined(separator: ""))


