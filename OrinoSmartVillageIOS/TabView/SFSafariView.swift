//
//  SFSafariView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 20/10/22.
//

import SwiftUI
import SafariServices

struct SFSafariView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = SFSafariViewController
    
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let vc = SFSafariViewController(url: url)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        //..
    }
}

struct SFSafariView_Previews: PreviewProvider {
    static var previews: some View {
        SFSafariView(url: URL(string: "https://orino-smart-village.web.app/index.html")!)
    }
}
