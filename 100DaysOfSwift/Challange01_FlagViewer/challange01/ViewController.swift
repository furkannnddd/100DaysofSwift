//
//  ViewController.swift
//  challange01
//
//  Created by Furkan DURSUN on 24.03.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flag Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true

        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".png") {
                var text = item
                let range = text.index(
                    text.endIndex, offsetBy: -7)..<text.endIndex
                text.removeSubrange(range)
                countries.append(text)
                countries.sort()
            }
        }
        print(countries)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        cell.imageView?.image = UIImage(
            named: "\(countries[indexPath.row])")
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        cell.textLabel?.text = countries[indexPath.row].uppercased()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = countries[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
                                                            

}

