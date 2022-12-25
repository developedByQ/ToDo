//
//  NewTask.swift
//  ToDoList
//
//  Created by Quinton Askew on 12/24/22.
//

import UIKit
import FirebaseFirestore

class NewTask: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    
    
    
    let priorities = ["Low", "Medium", "High", "ASAP"]
    
    var pickerView = UIPickerView()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "New Task"
        label.font = UIFont(name: "Avenir Next Bold", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    private var taskTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Task Name"
        label.font = UIFont(name: "Avenir Next Bold", size: 16)
        return label
    }()
    
    private var titleTextField:  UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = ""
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private var priorityTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Priority"
        label.font = UIFont(name: "Avenir Next Bold", size: 16)
        return label
    }()
    
    private var priorityTextField:  UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = ""
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private var descriptionLabel: UILabel = {
       let label = UILabel()
       label.text = "Task Description (Optional)"
       label.font = UIFont(name: "Avenir Next Bold", size: 16)
       return label
    }()
    
    private var descriptionTextField:  UITextView = {
        let textField = UITextView()
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 12
        return textField
    }()
    
    private var submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.tintColor = .white
        button.setTitle("Submit", for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 12
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemGray6
      
        self.configureViews()
        self.view.addSubview(titleLabel)
        self.view.addSubview(taskTitleLabel)
        self.view.addSubview(titleTextField)
        self.view.addSubview(priorityTitleLabel)
        self.view.addSubview(priorityTextField)
        pickerView.delegate = self
        pickerView.dataSource = self
        self.priorityTextField.inputView = pickerView
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(descriptionTextField)
        self.view.addSubview(submitButton)
        submitButton.addTarget(self, action: #selector(handleForm), for: .touchUpInside)
    }
    
    private func configureViews() {
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        titleLabel.frame = CGRect(x: 0, y: 40, width: Int(width), height: 20)
        taskTitleLabel.frame = CGRect(x: 20, y: 150, width: 200, height: 35)
        titleTextField.frame = CGRect(x: 20, y: 185, width: 200, height: 35)
        priorityTitleLabel.frame = CGRect(x: 20, y: 240, width: 200, height: 35)
        priorityTextField.frame = CGRect(x: 20, y: 275, width: 200, height: 35)
        descriptionLabel.frame = CGRect(x: 20, y: 325, width: 250, height: 35)
        descriptionTextField.frame = CGRect(x: 20, y: 360, width: 275, height: 200)
        submitButton.frame = CGRect(x: Int(width) / 2, y: Int(height) - 200, width: 200, height: 45)
        submitButton.center = CGPoint(x: Int(width)/2, y: Int(height) - 200)
    }
    
    @objc private func handleForm() {
        guard let taskName = self.titleTextField.text else {
            return
        }
        guard let priority = self.priorityTextField.text else {
            return
        }
        let taskDescription = self.descriptionTextField.text
        
        let database = Firestore.firestore()
        let root = database.collection("tasks")
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: now)
        
        let newTask = ["timestamp" : dateString, "taskname" : taskName, "priority" : priority, "taskdescription" : taskDescription ?? ""]
            
        root.addDocument(data: newTask) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                print("New Task Uploaded")
            }
            self.dismiss(animated: true, completion: nil)
       
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.priorities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.priorityTextField.text = priorities[row]
    }
    
    
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
