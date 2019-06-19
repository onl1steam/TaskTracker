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
    var fixedTaskList = [Task]()
    var task: Task?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fixedTaskList = CoreDataManager.shared.fetchData()
        filteredTasks = fixedTaskList
        
        self.tableView.tableFooterView = UIView()

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
    
    // Свайп вправо: позволяет изменить статус задачи
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let finishedStatus = UIContextualAction(style: .normal, title:  "Завершена", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let id = self.filteredTasks[indexPath.row].objectID
            CoreDataManager.shared.changeTaskStatus(with: id, status: "Завершена")
            self.filteredTasks[indexPath.row].status = "Завершена"
            self.fixedTaskList[indexPath.row].status = "Завершена"
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            success(true)
        })
        
        let inProgressStatus = UIContextualAction(style: .normal, title:  "В процессе", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let id = self.filteredTasks[indexPath.row].objectID
            CoreDataManager.shared.changeTaskStatus(with: id, status: "В процессе")
            self.filteredTasks[indexPath.row].status = "В процессе"
            self.fixedTaskList[indexPath.row].status = "В процессе"
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            success(true)
        })
        
        finishedStatus.backgroundColor = .gray
        inProgressStatus.backgroundColor = .green
        
        return UISwipeActionsConfiguration(actions: [finishedStatus, inProgressStatus])
        
    }

    // Свайп влево: позволяет удалить задачу
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title:  "Удалить", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let item = self.filteredTasks.remove(at: indexPath.row)
            self.fixedTaskList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            CoreDataManager.shared.deleteTask(by: item.objectID)
            success(true)
        })
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // Переходы
    
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
        if segue.identifier == "ShowPopover" {
            if let destinationVC = segue.destination as? PopoverViewController {
                destinationVC.delegate = self
            }
        }
    }
    
    // Протокол
    
    func childViewControllerResponse() {
        fixedTaskList = CoreDataManager.shared.fetchData()
        filteredTasks = fixedTaskList
        tableView.reloadData()
    }
    
    func childViewControllerFilterResponse(status: Status) {
        if status == .all {
            filteredTasks = fixedTaskList
            self.tableView.reloadData()
        } else {
            filteredTasks = fixedTaskList.filter({ (task) -> Bool in
                task.status == status.rawValue
            })
            self.tableView.reloadData()
        }
    }
}
