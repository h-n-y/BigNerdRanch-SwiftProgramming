import Cocoa

func findAll<T: Equatable>(array: [T], item: T) -> [Int] {
    
    var matchingIndices = [Int]()
    for (i, element) in array.enumerate() {
        if element == item {
            matchingIndices.append(i)
        }
    }
    return matchingIndices
}

print(findAll([5, 3, 7, 3, 9], item: 3))
