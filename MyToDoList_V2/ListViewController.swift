//
//  ViewController.swift
//  MyToDoList_V2
//
//  Created by Vasichko Anna on 02.02.2022.
//

import UIKit
import RealmSwift


class ListViewController: UITableViewController {
    
    private let lightColor = UIColor(
        red: 232/255,
        green: 221/255,
        blue: 167/255,
        alpha: 1)
    private let darkColor = UIColor(
        red: 64/255,
        green: 58/255,
        blue: 37/255,
        alpha: 1)
    private let greenColor = UIColor(
        red:89/255,
        green: 107/255,
        blue: 87/255,
        alpha: 1)
    
    private let cellID = "listCell"
    private var myList: Results<Task>!

    override func viewDidLoad() {
        super.viewDidLoad()
        myList = StorageManager.shared.realm.objects(Task.self)
        view.backgroundColor = lightColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorInset = .zero
        setupNavigationBar()
    }

// MARK: - Custom Navigation Bar
    
    private func setupNavigationBar() {
        title = "My To Do List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearence = UINavigationBarAppearance()
        navBarAppearence.configureWithOpaqueBackground()
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Futura-Medium", size: 17)!
        ]
        let attrsLarge = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Futura-Medium", size: 30)!
        ]
        navBarAppearence.titleTextAttributes = attrs
        
        navBarAppearence.largeTitleTextAttributes = attrsLarge
        
        navBarAppearence.backgroundColor = greenColor
        
        navigationController?.navigationBar.standardAppearance = navBarAppearence
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearence
    
        
        
        let navBarAddButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask))
        
        navBarAddButton.tintColor = .white
        
        let customSwitch = UISwitch()
        customSwitch.isOn = true
        customSwitch.addTarget(self, action: #selector(changeScreenMode), for: .valueChanged)
        customSwitch.onTintColor = UIColor.lightGray
        customSwitch.backgroundColor = darkColor
        customSwitch.layer.cornerRadius = 16
        customSwitch.layer.masksToBounds = true
        customSwitch.thumbTintColor = lightColor
        
        let navBarSwitch = UIBarButtonItem(customView: customSwitch)
        
        let darkModeLabel = UILabel()
        darkModeLabel.text = "Dark Theme"
        darkModeLabel.textColor = .white
        darkModeLabel.font = UIFont(name: "Futura-Medium", size: 16)
        
        let navModeLabel = UIBarButtonItem(customView: darkModeLabel)
        
        let navBarEditButton = editButtonItem
        navBarEditButton.image = UIImage(systemName: "square.and.pencil")
        navBarEditButton.tintColor = .white
        
        navigationItem.rightBarButtonItems = [navBarAddButton, navBarEditButton]
        navigationItem.leftBarButtonItems = [navBarSwitch, navModeLabel]
    }
    
    @objc private func addNewTask() {
        showAlert()
    }
    
    @objc private func changeScreenMode(sender: UISwitch) {
        let label = navigationItem.leftBarButtonItems?.last?.customView as! UILabel
        if sender.isOn {
            label.text = "Dark Theme"
            tableView.backgroundColor = lightColor
            tableView.separatorColor = .darkGray
            tableView.reloadData()
        } else {
            tableView.backgroundColor = darkColor
            tableView.separatorColor = greenColor
            navigationItem.leftBarButtonItems?.last?.title = "Light Theme"
            label.text = "Light Theme"
            tableView.reloadData()
        }
        }
    

}
// MARK: - Table view data source
extension ListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       myList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let task = myList[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = task.name
        content.textProperties.color = tableView.backgroundColor == lightColor ? .darkGray : .white
        content.textProperties.font = UIFont(name: "Futura-Medium", size: 18)!
        cell.contentConfiguration = content
        
        cell.tintColor = tableView.backgroundColor == lightColor ? .darkGray : .white
        cell.backgroundColor = tableView.backgroundColor
        
        cell.accessoryType = !task.isCompleted ? .none : .checkmark
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = myList[indexPath.row]
       
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { _, _, isDone in
            StorageManager.shared.delete(task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            isDone(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, isDone in
            self.showAlert(with: task) {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            isDone(true)
        }
        
        let doneAction = UIContextualAction(style: .normal, title: "Done") { _, _, isDone in
            StorageManager.shared.done(task)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            isDone(true)
        }
        
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        deleteAction.image = UIImage(systemName: "trash")
        editAction.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        editAction.image = UIImage(systemName: "square.and.pencil")
        
        doneAction.image = !task.isCompleted ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "xmark.circle")
        doneAction.backgroundColor = !task.isCompleted ? #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 0.7258640315) : #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.5065966474)
        
        return UISwipeActionsConfiguration(actions: [doneAction, deleteAction, editAction])
    }
    
}

// MARK: - Alert Controller

extension ListViewController {
    private func showAlert(with task: Task? = nil, completion: (() -> Void)? = nil) {
        let title = task != nil ? "Edit Task" : "New Task"
        let message = task != nil ? "Please correct the task" : "Please add new task!"
        let alert = UIAlertController.makeAlert(withTitle: title, andMessage: message)
        
        alert.action(with: task) { newName in
            if let task = task, let completion = completion {
                StorageManager.shared.edit(task, newName: newName)
                completion()
            } else {
                self.save(task: newName)
            }
        }
        present(alert, animated: true)
        
    }
    
    private func save(task: String) {
        let task = Task(value: [task])
        StorageManager.shared.save(task)
        let rowIndex = IndexPath(row: myList.index(of: task) ?? 0, section: 0)
        tableView.insertRows(at: [rowIndex], with: .automatic)
    }
}


