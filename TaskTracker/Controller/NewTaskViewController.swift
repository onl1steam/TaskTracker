//
//  NewTaskViewController.swift
//  TaskTracker
//
//  Created by Рыжков Артем on 15.06.2019.
//  Copyright © 2019 Рыжков Артем. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var taskNameTextView: UITextField!
    
    var delegate: ChildViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Настройка внешнего вида
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.6270869007)
        descriptionTextView.layer.cornerRadius = 16
    }
    
    @IBAction func addTask(_ sender: Any) {
        // Проверяем заполнение полей
        
        guard let text = taskNameTextView.text,
            let description = descriptionTextView.text else { showAlert(); return }
        
        if text.isEmpty || description.isEmpty {
            showAlert()
            return
        }
    
        CoreDataManager.shared.saveTask(name: text, date: Date(), status: "Новая", taskDescription: description)
        delegate?.childViewControllerResponse()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Заполните все поля", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }


}

