/*
    Chapter 19 Silver Challenge

    This solution solves the "hard" version of the challenge, whereby 
    all column and row alignments remain correct regardless of the length
    of the data items.

*/

import Cocoa

protocol TabularDataSource {
    var numberOfRows: Int { get }
    var numberOfColumns: Int { get }
    
    func labelForRow(row: Int) -> String
    func labelForColumn(column: Int) -> String
    
    func itemForRow(row: Int, column: Int) -> Int
}

func padding(amount: Int) -> String {
    
    var paddingString = ""
    for _ in 0..<amount {
        paddingString += " "
    }
    return paddingString
}

func printTable(dataSource: protocol<TabularDataSource, CustomStringConvertible>) {
    
    print("Table: \(dataSource.description)")
    
    // Create arrays of the row and column labels
    let rowLabels = (0..<dataSource.numberOfRows).map { dataSource.labelForRow($0) }
    let columnLabels = (0..<dataSource.numberOfColumns).map({
        (index: Int) -> String in
        dataSource.labelForColumn(index)
    })
    
    // Create an array of the width of each row label
    let rowLabelWidths = rowLabels.map { $0.characters.count }
    
    // Determine length of longest row label
    guard let maxRowLabelWidth = rowLabelWidths.maxElement() else {
        return
    }
    
    
    // SILVER CHALLENGE
    //
    // Determine the width of each column
    //  - the width of the column is controlled by the item (or label) with the
    //      greatest width in that column
    var columnWidths = [Int]()
    
    // iterate over each column
    for col in 0..<dataSource.numberOfColumns {
        
        // set initial max width to be the width of the column header
        let columnHeader = " \(columnLabels[col]) |"
        var maxColumnWidth = columnHeader.characters.count
        
        // search for row items with widths creater than column header
        for row in 0..<dataSource.numberOfRows {
            
            let item = dataSource.itemForRow(row, column: col)
            let itemWidth = " \(item) |".characters.count
            
            
            if itemWidth > maxColumnWidth {
                maxColumnWidth = itemWidth
            }
        }
        columnWidths.append(maxColumnWidth)
    }
    
    
    // Create first row containing column headers
    var firstRow: String = padding(maxRowLabelWidth) + " |"
    
    for i in 0..<dataSource.numberOfColumns {
        let columnHeader = " " + dataSource.labelForColumn(i) + " |"
        let paddingAmount = columnWidths[i] - columnHeader.characters.count
        firstRow += padding(paddingAmount) + columnHeader
    }
    print(firstRow)
    
    
    // Print remaining rows
    //
    for i in 0..<dataSource.numberOfRows {
        // Pad the row label out so they are all the same length
        let paddingAmount = maxRowLabelWidth - rowLabelWidths[i]
        var out = rowLabels[i] + padding(paddingAmount) + " |"
        
        // Append each item in this row to our string
        for j in 0..<dataSource.numberOfColumns {
            
            let item = dataSource.itemForRow(i, column: j)
            let itemString = " \(item) |"
            let paddingAmount = columnWidths[j] - itemString.characters.count
            
            out += padding(paddingAmount) + itemString
        }
        
        // Done - print it!
        print(out)
    }
}


struct Person {
    let name: String
    let age: Int
    let yearsOfExperience: Int
}

struct Department: TabularDataSource, CustomStringConvertible {
    let name: String
    var people = [Person]()
    
    init(name: String) {
        self.name = name
    }
    
    mutating func addPerson(person: Person) {
        people.append(person)
    }
    
    // CustomStringConvertible Protocol
    
    var description: String {
        return "Department (\(name))"
    }
    
    // TabularDataSouce Protocol
    
    var numberOfRows: Int {
        return people.count
    }
    
    var numberOfColumns: Int {
        return 2
    }
    
    func labelForRow(row: Int) -> String {
        return people[row].name
    }
    
    func labelForColumn(column: Int) -> String {
        switch column {
        case 0: return "Age"
        case 1: return "Years of Experience"
        default: fatalError("Invalid column!")
        }
    }
    
    func itemForRow(row: Int, column: Int) -> Int {
        let person = people[row]
        switch column {
        case 0: return person.age
        case 1: return person.yearsOfExperience
        default: fatalError("Invalid column!")
        }
    }
}

var department = Department(name: "Engineering")
department.addPerson(Person(name: "Joe", age: 3000000, yearsOfExperience: 6))
department.addPerson(Person(name: "Karen", age: 40, yearsOfExperience: 18))
department.addPerson(Person(name: "Fred", age: 50, yearsOfExperience: 20))

printTable(department)







