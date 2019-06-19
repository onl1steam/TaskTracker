//
//  PopoverViewController.swift
//  TaskTracker
//
//  Created by Рыжков Артем on 19.06.2019.
//  Copyright © 2019 Рыжков Артем. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Popupview: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var delegate: ChildViewControllerDelegate?
    
    var statuses: [Status] = [.all, .new, .inProgress, .finished ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Apply radius to Popupview
        Popupview.layer.cornerRadius = 10
        Popupview.layer.masksToBounds = true
        Popupview.layer.borderWidth = 0.5
        
        view.backgroundColor = .clear
        view.isOpaque = false
        
        self.tableView.tableFooterView = UIView()
        self.backgroundView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
    }
    
    
    // Returns count of items in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statuses.count;
    }
    
    @IBAction func onTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // Select item from tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.childViewControllerFilterResponse(status: statuses[indexPath.row])
    }
    
    //Assign values for tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statusCell", for: indexPath)
        
        cell.textLabel?.text = statuses[indexPath.row].rawValue
        
        return cell
    }
}
