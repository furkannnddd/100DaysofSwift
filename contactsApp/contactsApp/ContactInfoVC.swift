//
//  ContactInfoVC.swift
//  contactsApp
//
//  Created by Furkan DURSUN on 18.01.2023.
//

import UIKit

class ContactInfoVC: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    var contact: Contacts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let chosenContact = contact {
            numberLabel.text = chosenContact.contact_number
            firstNameLabel.text = chosenContact.contact_name
        }
    }
}
