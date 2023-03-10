//
//  ChiesaView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 20/12/22.
//

import SwiftUI

struct ChiesaView: View {
    
    let ripreseChiesa: [stringCard]
    
    var body: some View {
        ScrollView {
            ForEach(ripreseChiesa) { card in
                NavigationLink(destination: PanoramicImage(path: card.label).ignoresSafeArea().padding(.bottom)) {
                    TemplateCardView(label: card.label)
                        .shadow(color: Color("background-header-map"), radius: 16.0)
                        .padding([.vertical, .horizontal], 12.0)
                }
                Divider()
                    .padding(.horizontal, 12.0)
            }
        }
        .navigationTitle("Chiese")
    }
}

