//
//  StorageManager.swift
//  MyToDoList_V2
//
//  Created by Vasichko Anna on 02.02.2022.
//

import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    func save(_ task: Task){
        write {
            realm.add(task)
        }
    }
    
    func delete(_ task: Task) {
        write {
            realm.delete(task)
        }
    }
    
    func edit(_ task: Task, newName: String) {
        write {
            task.name = newName
        }
    }
    
    func done(_ task: Task) {
        write {
            task.isCompleted.toggle()
        }
    }
    
    private init() {}
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
    
    
    
}
