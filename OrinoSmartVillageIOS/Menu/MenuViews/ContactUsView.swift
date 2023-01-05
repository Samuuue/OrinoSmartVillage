//
//  ContactUsView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 24/10/22.
//

import SwiftUI

struct ContactUsView: View {
    var body: some View {
        VStack {
            Image("header-social")
                .resizable()
                .scaledToFit()
                .padding([.top, .horizontal], 10.0)
                .padding(.bottom, 50.0)
            Button {
                if let url = URL(string: "https://instagram.com/orinosmartvillage?igshid=YmMyMTA2M2Y=") {
                    UIApplication.shared.open(url)
                }
            } label: {
                HStack {
                    Image("instagram-logo")
                        .padding(.trailing, 5.0)
                        .padding([.leading, .vertical], 7.0)
                    
                    Text("@orimoSmartVillage")
                        .font(.title3)
                        .foregroundColor(Color("instagram-font"))
                        .padding([.trailing, .vertical], 7.0)
                        .underline()
                }
                .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color("instagram-font"), lineWidth: 1)
                    )
                .padding(.bottom, 20)
            }
            Divider()
            HStack {
                Image(systemName: "network")
                    .foregroundColor(Color.blue)
                    .padding(.trailing, 5.0)
                    .padding([.leading, .vertical], 7.0)
                    
                Text("www.orinosmartvillage.it")
                    .font(.title3)
                    .foregroundColor(Color("website-font"))
                    .padding([.trailing, .vertical], 7.0)
                    .underline()
            }
            .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color("website-font"), lineWidth: 1)
                )
            .padding(.top, 20)
            Spacer()
        }
    }
}
