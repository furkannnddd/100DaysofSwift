//
//  Person.swift
//  project10
//
//  Created by Furkan DURSUN on 19.04.2022.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
