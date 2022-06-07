//
//  ViewController.swift
//  ToDoList
//
//  Created by Furkan DURSUN on 25.05.2022.
//

import UIKit

class ViewController: UITableViewController {

    // MARK: Properties
    private var tasks = [Task]()
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "To Do List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        if let tasks = try? UserDefaultsManager.shared.getObject(forKey: "Tasks", castTo: [Task].self) {
            self.tasks = tasks
            tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let tasks = try? UserDefaultsManager.shared.getObject(forKey: "Tasks", castTo: [Task].self) {
            self.tasks = tasks
            tableView.reloadData()
        }
        // Taskı kaydetmeden önce, tüm taskları çek [Task]
        // Yeni taskı çektiğin arrayin sonuna append et
        // Artık elinde yeni bir [Task] var
        // bunu da userDEfaults'a kaydet
        // ana sayfaya gelince userDefaults'dab [Task] çek
        // controller içindeki tasks arrayini .removeAll() yap ya da direkt olarak
        // userDefaults çektiğin güncel [Task] arrayini ata
        // tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = task.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction] {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [self]
            action, indexPath in
            self.tasks.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)

            if var tasks = try? UserDefaultsManager.shared.getObject(forKey: "Tasks", castTo: [Task].self) {
                tasks.remove(at: indexPath.row)
                
                try? UserDefaultsManager.shared.setObject(tasks, forKey: "Tasks")
                taskDidSaved()
            }
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") {
            [self]
            action, indexPath in
            let vc = storyboard?.instantiateViewController(identifier: "Edit") as! EditViewController
            vc.title = "Edit Task"
            let cell = self.tableView.cellForRow(at: indexPath)
            guard let selectedTask = cell?.textLabel?.text else { return }
            vc.selectedTask = selectedTask
            navigationController?.pushViewController(vc, animated: true)
        }
        editAction.backgroundColor = .systemGreen
        return [deleteAction, editAction]
    }
    
    @objc func addTask() {
        
        let vc = storyboard?.instantiateViewController(identifier: "Entry") as! EntryViewController
        vc.title = "New Task"
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

}

// MARK: - Delegate
extension ViewController: Delegate, DelegateEdit {
    func taskDidSaved() {
        if let tasks = try? UserDefaultsManager.shared.getObject(forKey: "Tasks", castTo: [Task].self) {
            self.tasks = tasks
            tableView.reloadData()
        }
    }
}
