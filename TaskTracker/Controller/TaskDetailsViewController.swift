//
//  TaskDetailsViewController.swift
//  TaskTracker
//
//  Created by Рыжков Артем on 15.06.2019.
//  Copyright © 2019 Рыжков Артем. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UIViewController {

    @IBOutlet weak var nameView: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    
    var delegate: ChildViewControllerDelegate?
    var task: Task?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let task = task  else {return}

        nameView.text = task.name ?? ""
        descriptionView.text = task.taskDescription ?? ""
        
        // Настройка внешнего вида
        descriptionView.layer.borderWidth = 0.5
        descriptionView.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.6270869007)
        descriptionView.layer.cornerRadius = 16
    }
    
    // Сохранение изменений
    @IBAction func saveChanges(_ sender: Any) {
        
        guard let text = nameView.text,
            let description = descriptionView.text else { showAlert(); return }
        
        if text.isEmpty || description.isEmpty {
            showAlert()
            return
        }
        
        guard let id = task?.objectID else {return}
        CoreDataManager.shared.changeTaskInfo(with: id, name: nameView.text ?? "", description: descriptionView.text)
        delegate?.childViewControllerResponse()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Вывод предупреждения
    func showAlert() {
        let alert = UIAlertController(title: "Заполните все поля", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }

}
