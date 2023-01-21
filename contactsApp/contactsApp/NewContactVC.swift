//
//  NewContactVC.swift
//  contactsApp
//
//  Created by Furkan DURSUN on 18.01.2023.
//

import UIKit

class NewContactVC: UIViewController {

    let context = appDelegate.persistentContainer.viewContext

    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    @IBAction func addButton(_ sender: Any) {
        if let firstname = firstNameText.text, let number = numberText.text {
            let contact = Contacts(context: context)
            contact.contact_name = firstname
            contact.contact_number = number
            appDelegate.saveContext()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
