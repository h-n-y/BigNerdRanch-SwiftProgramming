import Cocoa

func beanSifter(groceryList list: [String]) -> (beans: [String], otherGroceries: [String]) {
    
    var beans = [String]()
    var other = [String]()
    
    // separate items in grocery list into beans and other
    for item in list {
        if item.hasSuffix("beans") {
            beans.append(item)
        } else {
            other.append(item)
        }
    }
    
    return ( beans, other )
}


let groceryList = [
    "green beans",
    "milk",
    "black beans",
    "pinto beans",
    "apples",
]
let result = beanSifter(groceryList: groceryList)

print("Beans: \(result.beans)")
print("Other: \(result.otherGroceries)")



