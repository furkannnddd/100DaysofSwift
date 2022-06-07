//
//  SceneDelegate.swift
//  project07
//
//  Created by Furkan on 3.04.2022.
//


import UIKit

class ViewController: UITableViewController {
	var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
	override func viewDidLoad() {
		super.viewDidLoad()

        let filterButton = UIBarButtonItem(title: "-Filter-", style: .plain, target: self, action: #selector(filterPetitions))
        let resetButton = UIBarButtonItem(title: "-Reset-", style: .plain, target: self, action: #selector(resetList))
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 40.0
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        navigationItem.leftBarButtonItems = [filterButton, spacer, resetButton]
        
		let urlString: String

		if navigationController?.tabBarItem.tag == 0 {
			urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
		} else {
			urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
		}

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }

        showError()
	}

    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.reloadData()
        }
    }

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredPetitions.count
	}
    
    @objc func resetList(action: UIAlertAction) {
        filteredPetitions = petitions
        tableView.reloadData()
    }
    
    @objc func filterPetitions() {
            let ac = UIAlertController(title: "Filter petitions", message: "Type in to filter...", preferredStyle: .alert)
            ac.addTextField()
            
            let filterAction = UIAlertAction(title: "Filter", style: .default) {
                [weak self, weak ac] _ in
                guard let filterWord = ac?.textFields?[0].text else { return }
                self?.performSelector(inBackground: #selector(self?.showPetitions(for:)), with: filterWord)
                self?.tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
            }
            
            ac.addAction(filterAction)
            present(ac, animated: true)
        }
    
    @objc func showPetitions(for filter: String) {
        filteredPetitions = filteredPetitions.filter { $0.title.lowercased().contains(filter) }
        }
        
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = filteredPetitions[indexPath.row]
        
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = DetailViewController()
		vc.detailItem = petitions[indexPath.row]
		navigationController?.pushViewController(vc, animated: true)
	}

	@objc func showError() {
		let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "OK", style: .default))
		present(ac, animated: true)
	}
}

