//
//  HomeCell.swift
//  ToDoList
//
//  Created by Quinton Askew on 12/23/22.
//

import UIKit

class HomeCell: UITableViewCell {

    static let identifier = "HomeCell"
    
    private let bgView: UIView = {
        let screenSize: CGRect = UIScreen.main.bounds
        let cellWidth = screenSize.width
        let cellHeight = 120
        let view = UIView(frame: CGRect(x: 10, y: 0, width: Int(cellWidth - 20), height: cellHeight))
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
     
        return view
    }()
    
    private let taskTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Avenir Next Medium", size: 18)
        return titleLabel
    }()
    
    private let timestampLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "Avenir Next Medium", size: 12)
        return label
    }()
    
    private let pill: UIView = {
       let pillView = UIView()
        pillView.layer.cornerRadius = 10
       return pillView
    }()
    
    private let taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "Avenir Next Medium", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        contentView.addSubview(timestampLabel)
        contentView.addSubview(taskTitleLabel)
        contentView.addSubview(pill)
        contentView.addSubview(taskDescriptionLabel)
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
    }
     
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.selectionStyle = .none
        contentView.frame = contentView.frame.inset(by:  UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0))
        timestampLabel.frame = CGRect(x: contentView.frame.size.width - 120, y: 10, width: 100, height: 20)
        taskTitleLabel.frame = CGRect(x: 20, y: 10, width: 250, height: 30)
        pill.frame = CGRect(x: 20, y: 40, width: 60, height: 20)
        taskDescriptionLabel.frame = CGRect(x: 20, y: 45, width: 350, height: 90)
    }
    
    func set(task: Task) {
        timestampLabel.text = task.timestamp
        taskTitleLabel.text = task.taskTitle
        taskDescriptionLabel.text = task.taskDescription
        let statusColor: UIColor
        switch task.priority {
        case .low:
            statusColor = .green
        case .medium:
            statusColor = .yellow
        case .high:
            statusColor = .red
        case .asap:
            statusColor = .black
        default:
            statusColor = .blue
        }
        pill.backgroundColor = statusColor
    }
}
