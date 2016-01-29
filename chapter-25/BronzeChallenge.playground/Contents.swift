import Cocoa

struct Point: Comparable {
    let x: Int
    let y: Int
}

func ==(lhs: Point, rhs: Point) -> Bool {
    return ( lhs.x == rhs.x ) && (lhs.y == rhs.y )
}

func <(lhs: Point, rhs: Point) -> Bool {
    return ( lhs.x < rhs.x ) && ( lhs.y < rhs.y )
}

// BRONZE CHALLENGE
//
func +(lhs: Point, rhs: Point) -> Point {
    return Point(x: ( lhs.x + rhs.x ), y: ( lhs.y + rhs.y) )
}

let a = Point(x: 1, y: 2)
let b = Point(x: 3, y: 5)
let c = a + b

print(c)