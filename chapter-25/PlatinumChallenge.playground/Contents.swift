/*
    PLATINUM CHALLENGE

    Add a computed property on `Point` ( *distanceFromOrigin* ) that returns
    the `Point`'s distance from the origin.

    Use this property when deciding if p1 < p2, where p1 and p2 are `Point` types.
*/

import Cocoa

struct Point: Comparable {
    let x: Int
    let y: Int
    
    var distanceFromOrigin: Double {
        get {
            return sqrt(Double(x) * Double(x) + Double(y) * Double(y))
        }
    }
}

func ==(lhs: Point, rhs: Point) -> Bool {
    return ( lhs.x == rhs.x ) && (lhs.y == rhs.y )
}

func <(lhs: Point, rhs: Point) -> Bool {
    return lhs.distanceFromOrigin < rhs.distanceFromOrigin
}

let c = Point(x: 3, y: 4)
let d = Point(x: 2, y: 5)

let cGreaterThanD   = ( c > d )
let cLessThanD      = ( c < d )
let cEqualToD       = ( c == d )
