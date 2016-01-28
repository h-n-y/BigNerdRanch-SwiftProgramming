/*
    GOLD CHALLENGE

        The return type for this function is changed from [Int] to [C.Index], where
    C.Index is the type used to subscript the *CollectionType*. *CollectionType*s have
    an *Index* property because they conform to the *Indexable* protocol.

    The Index type for Array<Element> is defined to be Int, but this is not the case for
    all collection types. For example, the index for *Set<Element: Hashable>* is defined as
    a *SetIndex<Element>*.


    *Note: 
    
    This function will not work with *Dictionary<Key: Hashable, Value>* types, because the
    *Element* for a Dictionary is defined as the tuple (Key, Value). Tuples do not conform to the
    *Equatable* protocol by default, so the constraint T: Equatable below precludes dictionary collection
    types from being used as the first argument to the function.

*/
import Cocoa

func findAll<T: Equatable, C: CollectionType where C.Generator.Element == T>(collection: C, item: T) -> [C.Index] {
    
    var matchingIndices: Array<C.Index> = []
    var currentIndex: C.Index = collection.startIndex
    
    for element in collection {

        if element == item {
            matchingIndices.append(currentIndex)
        }
        currentIndex = currentIndex.advancedBy(1)
    }

    return matchingIndices
}

print(findAll([5, 3, 7, 3, 9], item: 3))



var mySet = Set<Double>()
for num in [1.1, 2.2, 3.3] {
    mySet.insert(num)
}
print(findAll(mySet, item: 2.2))

