//
//  ErrorConnectionView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 20/11/22.
//

import SwiftUI

struct ErrorConnectionView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 15.0) {
            Image("Alert")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            
            Text(LocalizedStringKey("TitleConnection"))
                .font(.headline)
                .foregroundColor(.red)
        }
    }
}

