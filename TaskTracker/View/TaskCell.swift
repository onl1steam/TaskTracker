//
//  TaskCell.swift
//  TaskTracker
//
//  Created by Рыжков Артем on 15.06.2019.
//  Copyright © 2019 Рыжков Артем. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDateLabel: UILabel!
    @IBOutlet weak var taskStatusLabel: UILabel!
    
    // Настройка внешнего вида ячейки
    func configure(name: String, date: String, status: String) {
        taskNameLabel.text = name
        taskDateLabel.text = date
        taskStatusLabel.text = status
        switch taskStatusLabel.text {
        case "Новая":
            taskStatusLabel.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        case "Завершена":
            taskStatusLabel.textColor = .gray
        case "В процессе":
            taskStatusLabel.textColor = .green
        default:
            taskStatusLabel.textColor = .black
        }
    }
    
}
