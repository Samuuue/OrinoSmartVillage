//
//  OnboardingContainerView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 03/10/22.
//

import SwiftUI

struct OnboardingContainerView: View {
    var body: some View {
        TabView {
            ForEach(features) {
                feature in OnboardingContentView(feature: feature)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .edgesIgnoringSafeArea(.all)
    }
}
