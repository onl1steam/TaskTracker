//
//  DataManager.swift
//  TaskTracker
//
//  Created by Рыжков Артем on 17.06.2019.
//  Copyright © 2019 Рыжков Артем. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    private init() {
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        tasks = [Task]()
    }
    
    static let shared = CoreDataManager()
    var tasks: [Task]
    
    
    let appDelegate: AppDelegate
    let context: NSManagedObjectContext

    // Загрузка задачи из БД по NSManagedObjectID
    func fetchTask(with id: NSManagedObjectID) -> Task? {
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        var task: Task? = nil
        do {
            let data = try context.fetch(fetchRequest)
            data.forEach { (taskData) in
                if taskData.objectID == id {
                    task = taskData
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return task
    }
    
    // Загрузка из БД всех задач
    func fetchData() -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        var tasks = [Task]()
        
        do {
            let data = try context.fetch(fetchRequest)
            data.forEach { (taskData) in
                    tasks.append(taskData)
            }
            self.tasks = tasks
        } catch {
            print(error.localizedDescription)
        }
        return tasks
    }
    
    // Занесение новой задачи в БД
    func saveTask(name: String, date: Date, status: String, taskDescription: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        
        // Если нет, то добавляем новую запись в БД
        let newTask = NSManagedObject(entity: entity!, insertInto: context) as! Task
        newTask.setValue(name, forKey: "name")
        newTask.setValue(taskDescription, forKey: "taskDescription")
        newTask.setValue(date, forKey: "date")
        newTask.setValue(status, forKey: "status")
        // Сохранение данных
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Удаление задачи по NSManagedObjectID
    func deleteTask(by id: NSManagedObjectID) {
        let object = context.object(with: id)
        context.delete(object)

        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // Смена описания и названия задачи по NSManagedObjectID
    func changeTaskInfo(with id: NSManagedObjectID, name: String, description: String) {
        
        let object = context.object(with: id)
        object.setValue(name, forKey: "name")
        object.setValue(description, forKey: "taskDescription")
        
        do {
            try context.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // Смена статуса задачи по NSManagedObjectID
    func changeTaskStatus(with id: NSManagedObjectID, status: String) {
        
        let object = context.object(with: id)
        object.setValue(status, forKey: "status")
        
        do {
            try context.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
}
