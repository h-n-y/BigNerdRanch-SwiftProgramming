import UIKit

class ToDoList: NSObject {
    
    private let fileURL: NSURL = {
        let documentDirectoryURLs = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectoryURL = documentDirectoryURLs.first!
        return documentDirectoryURL.URLByAppendingPathComponent("todolist.items")
    }()
    
    private var items: [String] = []
    
    override init() {
        super.init()
        loadItems()
    }
    
    func saveItems() {
        let itemsArray = items as NSArray
        
        print("Saving items to \(fileURL)")
        if !itemsArray.writeToURL(fileURL, atomically: true) {
            print("Could not save to-do list")
        }
    }
    
    func loadItems() {
        if let itemsArray = NSArray(contentsOfURL: fileURL) as? [String] {
            items = itemsArray
        }
    }

    func addItem(item: String) {
        items.append(item)
        saveItems()
    }
}

extension ToDoList: UITableViewDataSource {
    
    // SILVER CHALLENGE
    //
    // The ViewController uses these computed properties when registering cells for
    // its table view if a ToDoList instance acts as the data source
    //
    var requiredTableViewCellClass: UITableViewCell.Type {
        return UITableViewCell.self
    }
    
    var cellReuseIdentifier: String {
        return "Cell"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath)
        let item = items[indexPath.row]
        
        cell.textLabel!.text = item
        
        return cell 
    }
}
