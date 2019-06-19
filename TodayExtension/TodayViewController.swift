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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func showTaskDetails(_ sender: Any) {
        self.extensionContext?.open(URL(string: "TaskDetails://")!, completionHandler: nil)
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}

