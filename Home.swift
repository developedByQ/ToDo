//
//  ViewController.swift
//  ToDoList
//
//  Created by Quinton Askew on 12/23/22.
//

import UIKit
import FirebaseFirestore

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
    
    var tasks: [Task] = []
    
    override func loadView() {
        super.loadView()
        
        self.configureView()
        self.setupTableView()
        self.getTasks()
    }

   
    

    fileprivate func configureView() {
        view.backgroundColor = UIColor.blue
        self.title = "Home"
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handlePresentingVC))
        self.navigationItem.setRightBarButton(addBtn, animated: true)
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
        self.tableView.backgroundColor = UIColor.systemGray6
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
    }
    
    
    fileprivate func getTasks() {
        self.tasks.removeAll()
        let database = Firestore.firestore()
        
        database.collection("tasks").getDocuments { (snapshot, error) in
            if error != nil {
               print(error!)
            }else{
                for doc in (snapshot?.documents)! {
                    
                    let taskname = doc.data()["taskname"] as! String
                    let timestamp = doc.data()["timestamp"] as! String
                    let priorityString = doc.data()["priority"] as! String
                    let priority = self.getPriority(priorityString: priorityString)
                    
                    if let taskdescription = doc.data()["taskdescription"] as? String {
                        let newTask = Task(timestamp: timestamp, taskTitle: taskname, taskDescription: taskdescription, priority: priority)
                        self.tasks.append(newTask)
                    }else{
                        let newTask = Task(timestamp: timestamp, taskTitle: taskname, taskDescription: "", priority: priority)
                        self.tasks.append(newTask)
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.refreshControl?.endRefreshing()
                        self.tableView.reloadData()
                    }
                    
                }
            }
            
            
        }

        
    }
    
    private func getPriority(priorityString: String) -> Priority {
        var priority: Priority
        switch priorityString {
        case "Low":
            priority = .low
        case "Medium":
            priority = .medium
        case "High":
            priority = .high
        case "ASAP":
            priority = .asap
        default:
            priority = .low
        }
        return priority
    }
    
    @objc func pullToRefresh() {
        self.getTasks()
    }
    
    @objc func handlePresentingVC() {
        let vc = NewTask()
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true, completion: nil)
      }
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


