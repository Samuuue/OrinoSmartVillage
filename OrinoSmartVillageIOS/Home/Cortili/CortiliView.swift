//
//  CortiliView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 04/01/23.
//

import SwiftUI

struct CortiliView: View {
    
    let ripreseCortili: [stringCard]
    
    var body: some View {
        ScrollView {
            ForEach(ripreseCortili) { card in
                NavigationLink(destination: PanoramicImage(path: card.label).ignoresSafeArea().padding(.bottom)) {
                    TemplateCardView(label: card.label)
                        .shadow(color: Color("background-header-map"), radius: 16.0)
                        .padding([.vertical, .horizontal], 12.0)
                }
                Divider()
                    .padding(.horizontal, 12.0)
            }
        }
        .navigationTitle("Cortili")
    }
}
