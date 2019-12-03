//
//  ImageLoader.swift
//  CollectionViewFooter
//
//  Created by dirtbag on 12/3/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

class ImageLoader {

    let placeHolder = [ "https://loremflickr.com/",
                        "https://placekitten.com/",
                        "https://www.placecage.com/",
                        "https://placebear.com/",
                        "https://picsum.photos/"
                    ]
    
    let index = 2
    
    let imageCache = [String: UIImage]()
    
    func loadImageInto(imageView: UIImageView, width: Int, height: Int) {
        
        // insert placeholder
        imageView.image = UIImage(named: "babyYoda")
        
        // load real image
        DispatchQueue.global(qos: .background).async {

            let urlString = "\(self.placeHolder[self.index])/\(width)/\(height)"
            
            self.loadImage(urlString: urlString) { (data) in

                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
                        imageView.image = image
                    }
                }
            }
        }
    }
    
    private func checkCache(dimString: String) -> UIImage? {
        
        return imageCache[dimString]
        
    }
    private func loadImage(urlString: String, imageLoaded: @escaping (Data) -> Void) {

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data = data else { return }

             imageLoaded(data)
        }.resume()
    }
}

