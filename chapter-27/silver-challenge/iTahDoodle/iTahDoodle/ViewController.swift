import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var itemTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    let todoList = ToDoList()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // SILVER CHALLENGE
        //
        // Here, the data source ( todoList ) now supplies the required class and cell reuse identifier
        //
        tableView.registerClass(todoList.requiredTableViewCellClass, forCellReuseIdentifier: todoList.cellReuseIdentifier)
        tableView.dataSource = todoList
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addButtonPressed(sender: UIButton) {
        guard let text = itemTextField.text where !text.isEmpty else {
            return
        }
        todoList.addItem(text)
        tableView.reloadData()
        
        // Clear item that was entered into text field
        itemTextField.text? = ""
    }
}

