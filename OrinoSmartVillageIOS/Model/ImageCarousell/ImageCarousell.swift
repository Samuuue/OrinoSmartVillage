//
//  ImageCarousell.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 03/10/22.
//

import Foundation
import SwiftUI
import FirebaseStorage
import UIKit

class ImagesCarousell: ObservableObject, Identifiable {
    
   @Published var images: [UIImage] = []
    
   @Published var showCarousell = false
    
    //let imageCache = NSCache<NSURL, UIImage>()
    
    var n_Element = 0
    
    var numbersToTake: [Int] = []

    let storage = Storage.storage()

    
    init() {
        self.downloadImages { succes in
            if succes {
                print("Success")
                self.showCarousell = true
            } else {
                print("Error")
            }
        }
    }
    
    func downloadImages(completion: @escaping (Bool) -> Void) {
        let imagesRef = storage.reference().child("orino-insta")
        
        var imagesRead = 0
        
        imagesRef.listAll { (result, error) in
            if let error = error {
                completion(false)
            } else {
                self.n_Element = result!.items.count
                self.genArrayInt()
                for item in result!.items {
                    if(self.numbersToTake.contains(imagesRead)) {
                        item.downloadURL { (url, error) in
                            if let error = error {
                                completion(false)
                            } else if let url = url {
                                item.getData(maxSize: 1 * 5000 * 5000) { [self] data, error in
                                    if let error = error {
                                        completion(false)
                                    } else if let data = data, let image = UIImage(data: data) {
                                        //imageCache.setObject(image, forKey: url as NSURL)
                                        self.images.append(image)
                                    }
                                }
                            }
                        }
                    }
                    imagesRead += 1
                    if(self.n_Element == imagesRead) {
                        print("okoko")
                        completion(true)
                    }
                }
            }
        }
    }
    private func genArrayInt() {
        // Genera 10 numeri interi casuali da 0 al numero di foto scaricate e aggiungili all'array
        for _ in 0..<10 {
            let randomNumber = Int(arc4random_uniform(UInt32(n_Element)))
            self.numbersToTake.append(randomNumber)
        }
    }
}


