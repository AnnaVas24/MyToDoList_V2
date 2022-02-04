//
//  ShowAlert.swift
//  MyToDoList_V2
//
//  Created by Vasichko Anna on 04.02.2022.
//

import UIKit

extension UIAlertController {
    
    static func makeAlert(withTitle title: String, andMessage message: String) -> UIAlertController {
        UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    func action(with task: Task?, completion: @escaping (String) -> Void) {
        let doneButton = task == nil ? "Save" : "Update"
    
        let saveAction = UIAlertAction(title: doneButton, style: .default) { _ in
            guard let newName = self.textFields?.first?.text else {return}
            guard !newName.isEmpty else {return}
            completion(newName)
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "New Task"
            textField.text = task?.name
            textField.font = UIFont(name: "Futura-Medium", size: 16)!
        }
        
        
    }
    
}

