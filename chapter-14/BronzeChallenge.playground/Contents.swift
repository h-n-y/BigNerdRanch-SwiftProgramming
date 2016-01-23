import Cocoa

enum ShapeDimensions {
    
    // Point has no associated value - it is dimensionless
    case Point
    
    // Square's associated value is the length of one side
    case Square(Double)
    
    // Rectangle's associated value defines its width and height
    case Rectangle(width: Double, height: Double)
    
    func area() -> Double {
        switch self {
            
        case .Point:
            return 0
            
        case let .Square(side):
            return side * side
            
        case let .Rectangle(width: w, height: h):
            return w * h
        }
    }
    
    // BRONZE CHALLENGE
    func perimeter() -> Double {
        switch self {
            
        case .Point:
            return 0
            
        case let .Square(side):
            return 4 * side
            
        case let .Rectangle(width: w, height: h):
            return 2 * ( w + h )
        }
    }
}

// Examples using the perimeter() method
var squareShape = ShapeDimensions.Square(10.0)
var rectShape   = ShapeDimensions.Rectangle(width: 5.0, height: 10.0)
var pointShape  = ShapeDimensions.Point

print("square's perimeter = \(squareShape.perimeter())")
print("rectangle's perimeter = \(rectShape.perimeter())")
print("point's perimeter = \(pointShape.perimeter())")


