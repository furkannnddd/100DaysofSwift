//
//  FilmCollectionViewCell.swift
//  filmlerApp
//
//  Created by Furkan DURSUN on 17.01.2023.
//

import UIKit

protocol FilmHucreProtocol {
    func sepeteEkle(indexPath:IndexPath)
}

class FilmCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var filmImageView: UIImageView!
    @IBOutlet weak var filmAdiLabel: UILabel!
    @IBOutlet weak var filmFiyatLabel: UILabel!
    
    var hucreProtocol: FilmHucreProtocol?
    var indexPath: IndexPath?
    
    @IBAction func sepeteEkleButton(_ sender: Any) {
        hucreProtocol?.sepeteEkle(indexPath: indexPath!)
    }
    
}
