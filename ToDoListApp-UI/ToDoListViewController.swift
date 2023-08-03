//  ToDoListViewController.swift
//  ToDoListApp-UI
//  Created by DA MAC M1 157 on 2023/08/01.

import UIKit


protocol ToDoListDelegate: AnyObject {
    func update(task: ToDoItemModel, index: Int )
}

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var toDoItems: [ToDoItemModel] = [ToDoItemModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        title = " To Do List"
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        
        let testItem = ToDoItemModel(name: "Test Item", details: "Test Details", completionDate: Date(), startDate: Date(), isComplete: true)
        let testItem2 = ToDoItemModel(name: "Test Item 2", details: "Test Detailssecond", completionDate: Date(), startDate: Date(), isComplete: false)
        
        let testItem3 = ToDoItemModel(name: "Test 3", details: "Test Details 3", completionDate: Date(), startDate: Date(), isComplete: false)
        self.toDoItems.append(testItem2)
        self.toDoItems.append(testItem)
        self.toDoItems.append(testItem3)
    }
    
    @objc func addTapped() {
        performSegue(withIdentifier: "AddTaskSegue", sender: nil)
        modalPresentationStyle = .fullScreen
    }
    
    
    @objc func editTapped() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing == true {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTapped))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        }
    }
}



extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate, ToDoListDelegate {
    
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
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoItems.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
  
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = toDoItems[indexPath.row]
        
        let toDoTuple = (indexPath.row, selectedItem)
        
        // Navigating from one VC to the other
        performSegue(withIdentifier: "TaskDetailsSegue", sender: toDoTuple)
    }
    
    
     //  Passing data with Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TaskDetailsSegue" {
            guard let destinationVC = segue.destination as? ToDoDetailsViewController else { return }
            guard let toDoTuple = sender as? (Int, ToDoItemModel) else { return }
            destinationVC.toDoItem = toDoTuple.1
            destinationVC.toDoIndex = toDoTuple.0
            destinationVC.delegate = self
        }
    }
    
    func update(task: ToDoItemModel, index: Int) {
        toDoItems[index] = task
        tableView.reloadData()
    }
}



// We want to update the VC where we have just come from.
// The best pattern to solve this pattern is a delegate.
// A delegate is one of three ways we can pass data
// We can pass data in 3 ways namely: 1. Segues    2. Delegates    3. NSNotification



// How to solve this?
// 1.  We are going to create a delegate for our ToDoListVC, which has the methods that we can use to update the ToDoListVC
// 2. We can pass an instance of that delegate to the ToDoDetailsVC and use that instance to update the ToDoListVC

// The protocol is a class bound protocol because we are going to use the weak keyword inorder for us to pass this delegate along
// The weak keyword can only be used with only classes.
// How to pass the protocol over
