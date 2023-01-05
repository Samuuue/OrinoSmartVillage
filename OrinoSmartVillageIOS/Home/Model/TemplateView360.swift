//
//  TemplateView360.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 04/01/23.
//

import Foundation
import SwiftUI

struct stringCard: Identifiable {
    let id = UUID()
    let label: String
}

struct TemplateCardView: View {
    
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
