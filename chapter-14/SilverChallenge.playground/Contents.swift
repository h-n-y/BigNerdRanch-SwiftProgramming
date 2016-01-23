import Cocoa

enum ShapeDimensions {
    
    // Point has no associated value - it is dimensionless
    case Point
    
    // Square's associated value is the length of one side
    case Square(Double)
    
    // Rectangle's associated value defines its width and height
    case Rectangle(width: Double, height: Double)
    
    
   
    case RightTriangle(base: Double, height: Double, hypotenuse: Double)     // SILVER CHALLENGE
    
    func area() -> Double {
        switch self {
            
        case .Point:
            return 0
            
        case let .Square(side):
            return side * side
            
        case let .Rectangle(width: w, height: h):
            return w * h
            
        // SILVER CHALLENGE
        case let .RightTriangle(base: b, height: h, hypotenuse: _):
            return 0.5 * b * h
        }
    }
}