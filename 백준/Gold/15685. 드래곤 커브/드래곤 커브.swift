let N = Int(readLine()!)!
var arr = Set<Point>()
struct Point: Hashable {
	let y: Int
	let x: Int
}

for _ in 0..<N {
	let input = readLine()!.split(separator: " ").map { Int($0)! }
	let y = input[1]
	let x = input[0]
	var d = [input[2]]
	let g = input[3]
	
	var currentPoint = Point(y: y, x: x)
	arr.insert(currentPoint)
	currentPoint = move(currentPoint, d: d.last!)!
	arr.insert(currentPoint)
	guard g > 0 else { continue }
	for _ in 1...g {
		for i in (0..<d.count).reversed() {
			let newD = (d[i] + 1) % 4
			d.append(newD)
			currentPoint = move(currentPoint, d: newD)!
			arr.insert(currentPoint)
		}
	}
}
var result = 0
arr.forEach { point in
	if arr.contains(Point(y: point.y + 1, x: point.x)) &&
		arr.contains(Point(y: point.y + 1, x: point.x + 1)) &&
		arr.contains(Point(y: point.y, x: point.x + 1)) {
			result += 1
		}
}
print(result)

func move(_ point: Point, d: Int) -> Point? {
	switch d {
		case 0:
			return Point(y: point.y, x: point.x + 1)
		case 1:
			return Point(y: point.y - 1, x: point.x)
		case 2:
			return Point(y: point.y, x: point.x - 1)
		case 3:
			return Point(y: point.y + 1, x: point.x)
		default: return nil
	}
}