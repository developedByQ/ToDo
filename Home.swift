//
//  ViewController.swift
//  ToDoList
//
//  Created by Quinton Askew on 12/23/22.
//

import UIKit

enum Priority {
    case low, medium, high, asap
}
struct Task {
    let timestamp: String!
    let taskTitle: String!
    let taskDescription: String?
    let priority: Priority!
    
}
class Home: UIViewController {

    let tableView = UITableView()
    
    var safeArea: UILayoutGuide!
    let tasks =
        [
            Task(timestamp: "5:00pm", taskTitle: "First Task", taskDescription: "The first task of today will be basic choirs. It has the lowest priority accepted.", priority: Priority.low),
            Task(timestamp: "6:00pm", taskTitle: "Optional Description", taskDescription: "", priority: Priority.low),
            Task(timestamp: "10:00pm", taskTitle: "Third Task", taskDescription: "The third task has medium priority.", priority: Priority.medium),
            Task(timestamp: "1:00am", taskTitle: "Fourth Task", taskDescription: "The fourth task has high priority.", priority: Priority.high),
            Task(timestamp: "3:00am", taskTitle: "Fifth Task!", taskDescription: "This task has the highest priority.", priority: Priority.asap),
            Task(timestamp: "12:00am", taskTitle: "Sixth Task", taskDescription: "Attmpting...", priority: Priority.medium),
            Task(timestamp: "11:00pm", taskTitle: "Seventh Task", taskDescription: "Attmpting...", priority: Priority.medium),
            Task(timestamp: "6:00am", taskTitle: "Eighth Task", taskDescription: "Attmpting...", priority: Priority.asap),
            Task(timestamp: "7:00pm", taskTitle: "Ninth Task", taskDescription: "Attmpting...", priority: Priority.low),
            Task(timestamp: "7:00am", taskTitle: "Tenth Task", taskDescription: "Attmpting...", priority: Priority.asap),
            Task(timestamp: "2:00am", taskTitle: "Task #11", taskDescription: "Attmpting...", priority: Priority.high),
            Task(timestamp: "8:00pm", taskTitle: "Task #12", taskDescription: "Attmpting...", priority: Priority.low),
            Task(timestamp: "4:00am", taskTitle: "Task #13", taskDescription: "Attmpting...", priority: Priority.asap),
            Task(timestamp: "5:00am", taskTitle: "Task #14", taskDescription: "Attmpting...", priority: Priority.asap),
            Task(timestamp: "9:00pm", taskTitle: "Task #15", taskDescription: "Attmpting...", priority: Priority.low)
        ]
    
    override func loadView() {
        super.loadView()
        
        self.configureView()
        self.setupTableView()
        
    }

   
    

    fileprivate func configureView() {
        view.backgroundColor = UIColor.blue
        self.title = "Home"
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil), animated: true)
        view.backgroundColor = UIColor.lightGray
        safeArea = view.layoutMarginsGuide
        
    }
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.identifier)
        self.tableView.rowHeight = 150
        self.tableView.separatorColor = .clear
        self.tableView.backgroundColor = UIColor.lightGray      }
}

extension Home: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tasks.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier, for: indexPath) as! HomeCell
    cell.backgroundColor = .clear
    let task = self.tasks[indexPath.row]
    cell.set(task: task)
    
    return cell
  }
    
  
}


