//
//  DataProvider.swift
//  TodayExtension
//
//  Created by Рыжков Артем on 19.06.2019.
//  Copyright © 2019 Рыжков Артем. All rights reserved.
//

import Foundation
import CoreData

class DataProvider {
    
    private init() {}
    static let shared = DataProvider()
    
    var container: PersistentContainer = PersistentContainer(name: "TaskTracker")
    
    // Загрузка последнего незавершенного задания (Проблема с загрузкой данных из CoreData)
    func getLastTask() -> Task? {
        
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        let coordinator = NSPersistentStoreCoordinator.init(managedObjectModel: container.managedObjectModel)
        
        var resultTask: Task?
        
        do {
            let data = try coordinator.execute(fetchRequest, with: context) as! [Task]
            print(data)
            // Фильтруем полученные листы
            let filteredList = data.filter { (task) -> Bool in
                let name = task.name
                return name != "Завершено"
            }
            if filteredList.isEmpty {
                return nil
            }
            resultTask = filteredList[0]
            // Выявляем ближайший по времени
            filteredList.forEach { (task) in
                guard let date1 = task.date,
                    let date2 = resultTask?.date else { return }
                if date1 > date2 {
                    resultTask = task
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        print(resultTask ?? "Empty")
        return resultTask
    }
    
}
