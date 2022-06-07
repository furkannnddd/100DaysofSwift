//
//  Task.swift
//  ToDoList
//
//  Created by Furkan DURSUN on 25.05.2022.
//

import Foundation

struct Task: Codable {
    var id = UUID()
    var title: String
}
