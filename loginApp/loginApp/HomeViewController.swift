//
//  HomeViewController.swift
//  loginApp
//
//  Created by Furkan DURSUN on 17.01.2023.
//

import UIKit

class HomeViewController: UIViewController {

    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var homeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        let kullaniciAdi = userDefaults.string(forKey: "kullaniciAdi") ?? "bos"
        homeLabel.text = kullaniciAdi
        
    }

    @IBAction func logOutButton(_ sender: Any) {
        userDefaults.removeObject(forKey: "kullaniciAdi")
        userDefaults.removeObject(forKey: "sifre")

        exit(-1)
    }

}
