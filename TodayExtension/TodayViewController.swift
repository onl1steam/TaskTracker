//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by Рыжков Артем on 18.06.2019.
//  Copyright © 2019 Рыжков Артем. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreData

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var task: Task?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        task = DataProvider.shared.getLastTask()
        guard let name = task?.name,
            let date = task?.date,
            let status = task?.status else { return }
        
        textLabel.text = name
        dateLabel.text = date.toString(dateFormat: "dd-mm-yy")
        statusLabel.text = status
        
    }
    
    // Если есть незавершенная задача, переходит на экран редактирования
    // Если задач нет, переходит на экран создания задачи
    @IBAction func showTaskDetails(_ sender: Any) {
        if task != nil {
            self.extensionContext?.open(URL(string: "TaskDetails://")!, completionHandler: nil)
        } else {
            self.extensionContext?.open(URL(string: "AddNewTask://")!, completionHandler: nil)
        }
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        completionHandler(NCUpdateResult.newData)
    }
    
}

