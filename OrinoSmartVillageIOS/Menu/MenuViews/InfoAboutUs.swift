//
//  InfoAboutUs.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 16/10/22.
//

import SwiftUI

struct InfoAboutUs: View {
    var body: some View {
        VStack {
            Image("logo-comune-menu")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 100.0)
                .padding(.top, 30.0)
                .padding(.bottom, 25.0)
            Image("fondazione-cariplo-logo")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 100.0)
                .padding(.top, 20.0)
                .padding(.bottom, 25.0)
            Text(LocalizedStringKey("info cariplo"))
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20.0)
                .padding(.top, 30.0)
            Text(LocalizedStringKey("info progetto"))
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding([.top, .leading, .trailing], 20.0)
            Image("insubria-logo")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 100.0)
                .padding(.top, 30.0)
                .padding(.bottom, 25.0)
            Spacer()
        }
    }
}

struct InfoAboutUs_Previews: PreviewProvider {
    static var previews: some View {
        InfoAboutUs()
    }
}
