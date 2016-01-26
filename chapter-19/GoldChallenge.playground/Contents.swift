/*
Chapter 19 Gold Challenge

Note: 
The return type for the function itemForRow(_:column:) in 
TabularDataSource protocol has been changed from Int to String

*/

import Cocoa

protocol TabularDataSource {
    var numberOfRows: Int { get }
    var numberOfColumns: Int { get }
    
    func labelForRow(row: Int) -> String
    func labelForColumn(column: Int) -> String
    
    func itemForRow(row: Int, column: Int) -> String
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


/*
    
    GOLD CHALLENGE

*/

struct AmazonBook {
    
    var title: String
    var author: String
    
    var rating: Double {
        
        // restrict rating to range [0, 5]
        didSet {
            
            if rating > 5 {
                rating = 5.0
            } else if rating < 0 {
                rating = 0
            }
        }
    }
}

struct BookCollection: TabularDataSource, CustomStringConvertible {
    
    var books = [AmazonBook]()
    
    // PROTOCOL: Custom String Convertible
    
    var description: String {
        return "Book Collection"
    }
    
    // PROTOCOL: Tabular Data Source
    
    var numberOfRows: Int {
        return books.count
    }
    
    var numberOfColumns: Int {
        return 3
    }
    
    func labelForRow(row: Int) -> String {
        return ""
    }
    
    func labelForColumn(column: Int) -> String {
        switch column {
            case 0: return "Title"
            case 1: return "Author"
            case 2: return "Rating"
            default: fatalError("Invalid column!")
        }
    }
    
    func itemForRow(row: Int, column: Int) -> String {
        let book = books[row]
        
        switch column {
            case 0: return book.title
            case 1: return book.author
            case 2: return "\(book.rating)"
            default: fatalError("Invalid column!")
        }
    }
}

var myBookCollection = BookCollection()
myBookCollection.books.append(AmazonBook(title: "My Name Is Lucy Barton", author: "Elizabeth Strout", rating: 3.5))
myBookCollection.books.append(AmazonBook(title: "The Girl on the Train", author: "Paula Hawkins", rating: 4.5))
myBookCollection.books.append(AmazonBook(title: "All the Light We Cannot See", author: "Anthony Doerr", rating: 4.6))
myBookCollection.books.append(AmazonBook(title: "Go Set a Watchman", author: "Harper Lee", rating: 4.0))

printTable(myBookCollection)







