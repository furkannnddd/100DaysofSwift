//
//  ViewController.swift
//  filmlerApp
//
//  Created by Furkan DURSUN on 17.01.2023.
//

import UIKit

class ViewController: UIViewController {

    var filmlerListesi = [Filmler]()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tasarim = UICollectionViewFlowLayout()
        let genislik = self.collectionView.frame.size.width
        
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumLineSpacing = 10
        tasarim.minimumInteritemSpacing = 10
        
        let hucreGenislik = (genislik-30) / 2
        tasarim.itemSize = CGSize(width: hucreGenislik, height: hucreGenislik * 1.6)
        collectionView!.collectionViewLayout = tasarim
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let f1 = Filmler(filmId: 1, filmBaslik: "Django", filmResimAdi: "django", filmFiyat: 15.99)
        let f2 = Filmler(filmId: 2, filmBaslik: "Inception", filmResimAdi: "inception", filmFiyat: 15.99)
        let f3 = Filmler(filmId: 3, filmBaslik: "Interstellar", filmResimAdi: "interstellar", filmFiyat: 15.99)
        let f4 = Filmler(filmId: 4, filmBaslik: "Anadoluda", filmResimAdi: "birzamanlaranadoluda", filmFiyat: 15.99)
        let f5 = Filmler(filmId: 5, filmBaslik: "The Hateful Eight", filmResimAdi: "thehatefuleight", filmFiyat: 15.99)
        let f6 = Filmler(filmId: 6, filmBaslik: "The Pianist", filmResimAdi: "thepianist", filmFiyat: 15.99)
        
        filmlerListesi.append(f1)
        filmlerListesi.append(f2)
        filmlerListesi.append(f3)
        filmlerListesi.append(f4)
        filmlerListesi.append(f5)
        filmlerListesi.append(f6)
    }
    



}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, FilmHucreProtocol{
    
    func sepeteEkle(indexPath: IndexPath) {
        let film = filmlerListesi[indexPath.row]
        print("\(film.filmBaslik!) filmi sipariş verildi.")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmlerListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let film = filmlerListesi[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FilmCollectionViewCell
        cell.filmImageView.image = UIImage(named: "\(film.filmResimAdi!)")
        cell.filmAdiLabel.text = film.filmBaslik
        cell.filmFiyatLabel.text = "\(film.filmFiyat!)"
        
        cell.hucreProtocol = self
        cell.indexPath = indexPath
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let film = filmlerListesi[indexPath.row]
        print("\(film.filmBaslik!) filmi seçildi.")
    }
}

