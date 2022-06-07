//
//  ViewController.swift
//  challange02
//
//  Created by Furkan DURSUN on 2.04.2022.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addList))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(removeList))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
    
        toolbarItems = [spacer, share]
        navigationController?.isToolbarHidden = false
        
    }
    
    @objc func addList() {
        let ac = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        
        let action = UIAlertAction(title: "Insert", style: .default) {
            [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else { return }
            self?.insert(item)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(cancel)
        ac.addAction(action)
        present(ac, animated: true)
        
    }
    
    func insert(_ item: String) {
        if item != "" {
            shoppingList.insert(item, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        } else {
            let ac = UIAlertController(title: "Blank item!", message: "This field must be filled.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Close", style: .cancel)
            ac.addAction(action)
            present(ac, animated: true)
        }
    }
    
    @objc func removeList() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func shareList() {
        let list = shoppingList.joined(separator: "\n")
        
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = toolbarItems?.last
        present(vc, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "List", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }

}

