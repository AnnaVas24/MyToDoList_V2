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
    private var myList: Results<task>!

    override func viewDidLoad() {
        super.viewDidLoad()
        myList = StorageManager.shared.realm.objects(task.self)
        view.backgroundColor = lightColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorInset = .zero
        setupNavigationBar()
    }

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
        
        navigationItem.rightBarButtonItem = navBarAddButton
        navigationItem.leftBarButtonItems = [navBarSwitch, navModeLabel]
        
    
    
    
    }
    
    @objc private func addNewTask() {
        
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
       // myList.count
        10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
//        let task = myList[indexPath.row]
//        var content = cell.defaultContentConfiguration()
//        content.text = task.name
//        cell.contentConfiguration = content
        
        
        var content = cell.defaultContentConfiguration()
        content.text = "blabla"
        content.textProperties.color = tableView.backgroundColor == lightColor ? .darkGray : .white
        content.textProperties.font = UIFont(name: "Futura-Medium", size: 18)!
        cell.contentConfiguration = content
        
        cell.backgroundColor = tableView.backgroundColor
        return cell
    }
}

