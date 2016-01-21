import Cocoa

var population: Int = 112_432
var message: String
var hasPostOffice: Bool = true

if population < 10_000 {
    
    message = "\(population) is a small town!"
    
} else if population >= 10_000 && population < 50_000 {
    
    message = "\(population) is a medium town!"
    
} else if population >= 50_000 && population < 100_000 {
    
    message = "\(population) is pretty big!"
    
} else {
    
    message = "\(population) is huge!"
}

print(message)

if !hasPostOffice {
    print("Where do we buy stamps?")
}