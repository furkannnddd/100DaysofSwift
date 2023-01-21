//
//  ViewController.swift
//  contactsApp
//
//  Created by Furkan DURSUN on 18.01.2023.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ContactsVC: UIViewController {

    let context = appDelegate.persistentContainer.viewContext
    
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "newContactSegue", sender: nil)
    }
    @IBOutlet weak var tableView: UITableView!
    var ContactsList = [Contacts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        giveContacts()
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        
        if segue.identifier == "editContactSegue" {
            let newVC = segue.destination as! EditContactVC
            newVC.contact = ContactsList[index!]
        }
        
        if segue.identifier == "contactInfoSegue" {
            let newVC = segue.destination as! ContactInfoVC
            newVC.contact = ContactsList[index!]
        }
    }
    
    func giveContacts() {
        do {
            ContactsList = try context.fetch(Contacts.fetchRequest())
        } catch {
            print("error")
        }
    }

}

extension ContactsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ContactsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = ContactsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(contact.contact_name!) - \(contact.contact_number!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "contactInfoSegue", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAC = UIContextualAction(style: .destructive, title: "Delete") {
            (contextualAction, view, boolValue) in
            let contact = self.ContactsList[indexPath.row]
            self.context.delete(contact)
            appDelegate.saveContext()
            self.giveContacts()
            self.tableView.reloadData()
        }
        let editAC = UIContextualAction(style: .normal, title: "Edit") {
            (contextualAction, view, boolValue) in
            self.performSegue(withIdentifier: "editContactSegue", sender: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [deleteAC, editAC])
    }
    
}
