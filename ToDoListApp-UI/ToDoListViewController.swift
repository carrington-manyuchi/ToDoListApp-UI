//  ToDoListViewController.swift
//  ToDoListApp-UI
//  Created by DA MAC M1 157 on 2023/08/01.

import UIKit

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var toDoItems: [ToDoItemModel] = [ToDoItemModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        title = " To Do List"
        
        let testItem = ToDoItemModel(name: "Test Item", details: "Test Details", completionDate: Date(), startDate: Date(), isComplete: true)
        let testItem2 = ToDoItemModel(name: "Test Item 2", details: "Test Detailssecond", completionDate: Date(), startDate: Date(), isComplete: false)
        
        self.toDoItems.append(testItem2)
        self.toDoItems.append(testItem)
    }
}



extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let toDoItem = toDoItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem", for: indexPath)
        
        cell.textLabel?.text = toDoItem.name
        cell.detailTextLabel?.text = toDoItem.isComplete ? "Complete" : "InComplete"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "TaskDetailsSegue", sender: nil)
        
    }
}
