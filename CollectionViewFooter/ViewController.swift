//
//  ViewController.swift
//  CollectionViewFooter
//
//  Created by dirtbag on 12/3/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ViewController: UICollectionViewDataSource {
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 100 //Int(pow(Double(section + 1),Double(2)))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCell", for: indexPath) as? CatCollectionViewCell
            else { return UICollectionViewCell() }
        
        let width = Int.random(in: 150...250)
        let height = Int.random(in: 150...250)
        
        cell.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        ImageLoader().loadImageInto(imageView: cell.imageView, width: width, height: height)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionView.elementKindSectionFooter) {
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterCell", for: indexPath) as? FooterView
                else { return UICollectionReusableView() }
            
            footerView.lblFooter.text = "This is my Footer"
            
            // Customize footerView here
            return footerView
        }
        return UICollectionReusableView()
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    
}
