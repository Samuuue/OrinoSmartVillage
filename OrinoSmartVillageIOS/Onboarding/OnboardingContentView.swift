//
//  OnboardingContentView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 03/10/22.
//

import SwiftUI

let features = [
    Feature(title: String(localized: "Onboarding1Title"), label: String(localized: "Onboarding1Label"), image: "montain"),
    Feature(title: String(localized: "Onboarding2Title"), label: String(localized: "Onboarding2Label"), image: "qrcode-scanning"),
    Feature(title: String(localized: "Onboarding3Title"), label: String(localized: "Onboarding3Label"), image: "start")
]

struct OnboardingContentView: View {
    
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    var feature: Feature
    
    var body: some View {
        VStack {
            Image(feature.image)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 10.0)
            
            Text(feature.title)
                .font(.title)
                .fontWeight(.bold)
                .font(.system(size: 20))
                .padding(.top, 20.0)
                .padding(.horizontal, 10.0)
            
            Text(feature.label)
                .font(.body)
                .font(.system(size: 30))
                .multilineTextAlignment(.center)
                .padding(.top, 20.0)
                .padding(.horizontal, 10.0)
            
            Button(action: {
                isOnboarding = false
            },
                   label: {
                ZStack {
                    Rectangle()
                        .frame(width: 150, height: 40)
                        .foregroundColor(Color("background-button-onboarding"))
                        .cornerRadius(20)
                        .shadow(radius: 10)
                    ZStack{
                        if (feature.image == "start") {
                            Text(LocalizedStringKey("OnboardingIniziamo"))
                                .font(.system(size: 13))
                                .foregroundColor(.black)
                        } else {
                            Text(LocalizedStringKey("OnboardingSalta"))
                                .font(.system(size: 13))
                                .foregroundColor(.black)
                        }
                    }
                }
            })
            .padding(.top, 100.0)
        }
    }
    
    struct OnboardingContentView_Previews: PreviewProvider {
        static var previews: some View {
            OnboardingContentView(feature: features[0])
        }
    }
}
