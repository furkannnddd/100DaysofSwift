//
//  ViewController.swift
//  loginApp
//
//  Created by Furkan DURSUN on 17.01.2023.
//

import UIKit

class ViewController: UIViewController {

    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var kullaniciAdiLabel: UITextField!
    @IBOutlet weak var sifreLabel: UITextField!
    
    @IBAction func buttonGiris(_ sender: Any) {

        if let kullaniciAdi = kullaniciAdiLabel.text, let sifre = sifreLabel.text {
            if kullaniciAdi == "admin" && sifre == "123456" {
                userDefaults.set(kullaniciAdi, forKey: "kullaniciAdi")
                userDefaults.set(sifre, forKey: "sifre")
                performSegue(withIdentifier: "loginTOhome", sender: nil)
            } else {
                let ac = UIAlertController(title: "Hata", message: "Kullanıcı Adı veya Şifre yanlıştır.", preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK", style: .cancel)
                ac.addAction(OK)
                self.present(ac, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let sifre = userDefaults.string(forKey: "sifre") ?? "bos"
        let kullaniciAdi = userDefaults.string(forKey: "kullaniciAdi") ?? "bos"
        
        if kullaniciAdi != "bos" && sifre != "bos" {
            performSegue(withIdentifier: "loginTOhome", sender: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }


}

