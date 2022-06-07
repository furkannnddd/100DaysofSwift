//
//  TableViewController.swift
//  project04
//
//  Created by Furkan DURSUN on 26.03.2022.
//

import UIKit

class TableViewController: UITableViewController {
    var websites = ["apple.com", "hackingwithswift.com", "google.com", "karkasciftligi.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? ViewController {
            vc.selectedWebsite = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
