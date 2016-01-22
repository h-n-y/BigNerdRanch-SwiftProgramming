import Cocoa

func greetByMiddleName(name: (first: String, middle: String?, last: String)) {
    
    guard let middleName = name.middle where middleName.characters.count < 4 else {
        print("Hey there!")
        return
    }
    print("Hey \(middleName)")
}

greetByMiddleName(("Hans", "Nikohlas", "Yelek"))
