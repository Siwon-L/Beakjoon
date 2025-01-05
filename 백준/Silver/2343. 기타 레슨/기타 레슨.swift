let NM = readLine()!.split(separator: " ").map { Int($0)! }
let N = NM[0]
let M = NM[1]

let lengths = readLine()!.split(separator: " ").map { Int($0)! }

var left = lengths.max()!
var right = lengths.reduce(0,+)

while left <= right {
	let mid: Int = (left + right) / 2
	
	var blurayCount = 1
	var size = 0
	
	for length in lengths {
		if size + length > mid {
			blurayCount += 1
			size = 0
		}
		size += length
	}
		
	if blurayCount <= M {
		right = mid - 1
	} else {
		left = mid + 1
	}
}

print(left)
