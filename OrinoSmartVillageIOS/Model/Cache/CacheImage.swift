//
//  ImageCache.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 28/10/22.
//

import Foundation
import UIKit
import FirebaseStorage

class CacheImage: ObservableObject {
    
    let imageCache = NSCache<NSString, UIImage>()
    
    let storage = Storage.storage()
        
    public func downloadImage(path: String, completion: @escaping (UIImage?) -> ()){
        
        let pathArray = path.components(separatedBy: "/")
        
        let storageRef = storage.reference(withPath: path)
        
        if let cacheImage = imageCache.object(forKey: pathArray[1] as NSString) {
            let image: UIImage = cacheImage
            completion(image)
        } else {
            storageRef.getData(maxSize: 1 * 10240 * 10240) { data, error in
                if let error = error {
                    print("Error")
                    return
                }
                let image: UIImage = UIImage(data: data!)!
                self.imageCache.setObject(image, forKey: pathArray[1] as NSString)
                completion(image)
            }
        }
    }
}

