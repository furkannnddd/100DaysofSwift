//
//  EditContactVC.swift
//  contactsApp
//
//  Created by Furkan DURSUN on 18.01.2023.
//

import UIKit

class EditContactVC: UIViewController {

    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    @IBAction func saveButton(_ sender: Any) {
        if let firstname = firstNameText.text, let number = numberText.text {
            contact?.contact_name = firstname
            contact?.contact_number = number
            appDelegate.saveContext()
        }
        
    }
    var contact: Contacts?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let chosenContact = contact {
            firstNameText.text = chosenContact.contact_name
            numberText.text = chosenContact.contact_number
        }

        
    }
}
