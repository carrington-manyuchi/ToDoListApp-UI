//
//  ToDoDetailsViewController.swift
//  ToDoListApp-UI
//
//  Created by DA MAC M1 157 on 2023/08/01.
//

import UIKit

class ToDoDetailsViewController: UIViewController {

    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskDetailsTextView: UITextView!
    @IBOutlet weak var taskCompletionButton: UIButton!
    @IBOutlet weak var taskCompletionDate: UILabel!

    var toDoItem: ToDoItemModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTitleLabel.text = toDoItem.name
        taskDetailsTextView.text = toDoItem.details
        
        if toDoItem.isComplete {
            disableButton()
        }
        
        // formattingDate to String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy hh:mm "
        
        let taskDate = dateFormatter.string(from: toDoItem.completionDate)
        
        taskCompletionDate.text = taskDate
    }

    
    func disableButton() {
        taskCompletionButton.backgroundColor = .gray
        taskCompletionButton.isEnabled = true
    }
    
    @IBAction func taskDidComplete(_ sender: UIButton) {
    }
}
