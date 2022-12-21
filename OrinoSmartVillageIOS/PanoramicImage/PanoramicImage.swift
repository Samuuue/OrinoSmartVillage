//
//  PanoramicImage.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 26/10/22.
//

import SwiftUI

struct PanoramicImage: UIViewRepresentable {
    
    @EnvironmentObject private var myImageCache: CacheImage
    
    typealias UIViewType = CTPanoramaView
    
    var path: String

    func makeUIView(context: Context) -> CTPanoramaView {
        var view = CTPanoramaView()
            
        myImageCache.downloadImage(path: path) { (completion) in
            view.image = completion
            view.controlMethod = .both
        }
        return view
    }
    
    func updateUIView(_ uiView: CTPanoramaView, context: Context) {
        //..
    }
}
