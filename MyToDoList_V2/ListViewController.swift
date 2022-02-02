//
//  ViewController.swift
//  MyToDoList_V2
//
//  Created by Vasichko Anna on 02.02.2022.
//

import UIKit

class ListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(
            red: 232/255,
            green: 221/255,
            blue: 167/255,
            alpha: 1)
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
        
        navBarAppearence.backgroundColor = UIColor(
            red:89/255,
            green: 107/255,
            blue: 87/255,
            alpha: 1)
        
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
        customSwitch.backgroundColor = UIColor(
            red: 64/255,
            green: 58/255,
            blue: 37/255,
            alpha: 1)
        customSwitch.layer.cornerRadius = 16
        customSwitch.layer.masksToBounds = true
        customSwitch.thumbTintColor = UIColor(
            red: 232/255,
            green: 221/255,
            blue: 167/255,
            alpha: 1)
        
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
            view.backgroundColor = UIColor(
                red: 232/255,
                green: 221/255,
                blue: 167/255,
                alpha: 1)
            label.text = "Dark Theme"
        } else {
            view.backgroundColor = UIColor(
                red: 64/255,
                green: 58/255,
                blue: 37/255,
                alpha: 1)
            navigationItem.leftBarButtonItems?.last?.title = "Light Theme"
            label.text = "Light Theme"
        }
        }
    

}

