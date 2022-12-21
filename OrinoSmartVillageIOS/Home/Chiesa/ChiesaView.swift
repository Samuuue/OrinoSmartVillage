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
                    CardChiesaView(label: card.label)
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

struct CardChiesaView: View {
    
    let label: String
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(label))
                .font(.headline)
                .foregroundColor(Color("color-text-feed"))
                .padding(.leading, 10.0)
            Spacer()
            Image("360-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 80.0, height: 80.0)
                .padding(.trailing, 10.0)
        }
        .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color("background-header-map"), lineWidth: 1)
        )
    }
}

struct stringCard: Identifiable {
    let id = UUID()
    let label: String
}

//destination: PanoramicImage(path: "orino-360/R0010056_20221020103956.jpg")
