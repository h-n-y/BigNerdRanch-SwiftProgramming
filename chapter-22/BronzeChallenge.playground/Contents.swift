import Cocoa

struct StackGenerator<T>: GeneratorType {
    
    var stack: Stack<T>
    
    mutating func next() -> T? {
        return stack.pop()
    }
}


struct Stack<Element>: SequenceType {
    
    var items = [Element]()
    
    mutating func push(newItem: Element) {
        items.append(newItem)
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else {
            return nil
        }
        return items.removeLast()
    }
    
    func map<U>(f: Element -> U) -> Stack<U> {
        var mappedItems = [U]()
        for item in items {
            mappedItems.append(f(item))
        }
        return Stack<U>(items: mappedItems)
    }
    
    // Protocol: Sequence Type
    typealias Generator = StackGenerator<Element>
    func generate() -> StackGenerator<Element> {
        return StackGenerator(stack: self)
    }
    
    
    // BRONZE CHALLENGE
    //
    func filter(f:(Element) -> (Bool)) -> Stack<Element> {
        var filteredStack = Stack<Element>()
        
        for item in self {
            if f(item) {
                filteredStack.push(item)
            }
        }
        return filteredStack
    }
}


// filter(_:) example
//
//
var myStack = Stack<Int>()
for num in [-5, -4, -3, -2, -1, 0, 1, 2, 3] {
    myStack.push(num)
}

// filter out all non-negative numbers
var myStackNegatives = myStack.filter() {
    (let num: Int) -> (Bool) in
    return num < 0
}

// print filtered stack
for num in myStackNegatives {
    print("\(num)")
}





















