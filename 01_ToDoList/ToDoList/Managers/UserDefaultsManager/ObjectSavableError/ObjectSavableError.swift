//
//  File.swift
//  ToDoList
//
//  Created by Furkan DURSUN on 7.06.2022.
//

import Foundation

/// Enum that covers `UserDefaultsManager` operation error cases
enum ObjectSavableError: String, LocalizedError {

    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }

}
