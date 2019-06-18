//
//  TaskListViewController.swift
//  TaskTracker
//
//  Created by Рыжков Артем on 15.06.2019.
//  Copyright © 2019 Рыжков Артем. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChildViewControllerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var filteredTasks = [Task]()
    var task: Task?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredTasks = CoreDataManager.shared.fetchData()

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskCell
        let task = filteredTasks[indexPath.row]
        guard let name = task.name,
            let date = task.date,
            let status = task.status else { return cell}
        cell.configure(name: name, date: date.toString(dateFormat: "dd-MM-yy"), status: status)
     
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        task = filteredTasks[indexPath.row]
        
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        performSegue(withIdentifier: "ShowTaskDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Удалить") { (action, indexPath) in
            let item = self.filteredTasks.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            CoreDataManager.shared.deleteTask(by: item.objectID)
        }
        return [delete]
    }
    
    // Segue
    
    @IBAction func addNewTask(_ sender: Any) {
        performSegue(withIdentifier: "AddNewTask", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTaskDetails" {
            if let destinationVC = segue.destination as? TaskDetailsViewController {
                destinationVC.task = task
                destinationVC.delegate = self
            }
        }
        if segue.identifier == "AddNewTask" {
            if let destinationVC = segue.destination as? NewTaskViewController {
                destinationVC.delegate = self
            }
        }
    }
    
    // Protocols
    
    func childViewControllerResponse() {
        filteredTasks = CoreDataManager.shared.fetchData()
        tableView.reloadData()
    }
}
