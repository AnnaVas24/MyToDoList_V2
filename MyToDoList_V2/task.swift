//
//  toDoList.swift
//  MyToDoList_V2
//
//  Created by Vasichko Anna on 02.02.2022.
//

import RealmSwift

class Task: Object {
    @Persisted var name = ""
    @Persisted var isCompleted = false
}
