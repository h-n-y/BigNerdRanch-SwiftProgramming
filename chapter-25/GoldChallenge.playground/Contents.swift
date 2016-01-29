/*
    GOLD CHALLENGE

    The method indexOf(_:) is made available in an extension on `CollectionType` that
    requires the `CollectionType`s `Element`s to conform to the `Equatable` protocol.

    `Array<Person>` ( the type of *people*, below ) conforms to `CollectionType`, but `Person` 
    must also conform to `Equatable` in order to access the indexOf(_:) method.

    Here, I've made two `Person` types considered equal if their name and age types 
    are themselves equal.
*/

import Cocoa

class Person: Equatable {
    let name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

func ==(lhs: Person, rhs: Person) -> Bool {
    return ( lhs.name == rhs.name ) && ( lhs.age == rhs.age )
}

let p1 = Person(name: "John", age: 26)
let p2 = Person(name: "Jane", age: 22)
var people: [Person] = [p1, p2]

let p1Index = people.indexOf(p1)