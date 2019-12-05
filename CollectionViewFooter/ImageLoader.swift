//
//  ImageLoader.swift
//  CollectionViewFooter
//
//  Created by dirtbag on 12/3/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

class ImageLoader {

    var imageCache = [String: UIImage]()
    let index = 2
    let placeHolder = [ "https://loremflickr.com/",
                        "https://placekitten.com/",
                        "https://www.placecage.com/",
                        "https://placebear.com/",
                        "https://picsum.photos/"
                    ]
        
    func loadImageInto(imageView: UIImageView, width: Int, height: Int) {
        
        // check the cache
        let dimString = "\(width)/\(height)"
        if checkCache(imageView: imageView, dimString: dimString) {
            return
        }

        // insert placeholder
        imageView.image = UIImage(named: K.Image.babyYoda)
        
        // load real image
        DispatchQueue.global(qos: .background).async {

            let urlString = "\(self.placeHolder[self.index])/\(dimString)"
            
            self.loadImage(urlString: urlString) { (data) in

                if let image = UIImage(data: data) {
                    self.updateUI(imageView: imageView, image: image)
                    self.imageCache[dimString] = image
                }
            }
        }
    }
    
    private func updateUI(imageView: UIImageView, image: UIImage) {
        DispatchQueue.main.async {
            //imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            imageView.image = image
        }
    }
    
    private func checkCache(imageView: UIImageView, dimString: String) -> Bool {
        
        guard let image = imageCache[dimString] else { return false }
        
        updateUI(imageView: imageView, image: image)
        print("Cache hit!")
        
        return true
    }
    private func loadImage(urlString: String, imageLoaded: @escaping (Data) -> Void) {

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data = data else { return }

             imageLoaded(data)
        }.resume()
    }
}
