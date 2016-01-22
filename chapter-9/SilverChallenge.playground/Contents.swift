import Cocoa

// array to reverse
var toDoList = [
    "Take out garbage",
    "Pay bills",
    "Cross off finished items",
]

/*

FIRST SOLUTION

    Iterate through the elements of toDoList in order and insert
    a copy of each element into the [0] index of a new array,
    toDoListReversed

*/

var toDoListReversed: [String] = []
for item in toDoList {
    toDoListReversed.insert(item, atIndex:0)
}

toDoList = toDoListReversed
print(toDoList)


/*

SECOND SOLUTION

Use toDoList's reverse() method to reverse the elements of the array.
The reverse() method is available because the Array type conforms to 
the CollectionType protocol.

*/

// reset toDoList to its original value
toDoList = [
    "Take out garbage",
    "Pay bills",
    "Cross off finished items",
]

toDoList = toDoList.reverse()
print(toDoList)

