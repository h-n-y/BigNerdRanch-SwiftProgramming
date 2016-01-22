import Cocoa


var groceryBag: Set = ["Apples", "Oranges", "Pineapple"]

for food in groceryBag {
    print(food)
}

let hasBananas = groceryBag.contains("Bananas")
let friendsGroceryBag = Set(["Bananas", "Cereal", "Milk", "Oranges"])

// modify groceryBag to include unique elements from friendsGroceryBag
groceryBag.unionInPlace(friendsGroceryBag)

let roommatesGroceryBag = Set(["Apples", "Bananas", "Cereal", "Toothpaste"])

// remove any elements from groceryBag that are not also in roommatesGroceryBag
groceryBag.intersectInPlace(roommatesGroceryBag)

