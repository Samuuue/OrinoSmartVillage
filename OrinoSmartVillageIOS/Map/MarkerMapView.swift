//
//  MarkerMapView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 13/10/22.
//

import SwiftUI

struct MarkerMapView: View {
    
    let color = Color("background-header-map")
    
    let location: Location
    
    var body: some View {
        VStack(spacing: 0) {
            Text(location.name)
                .fontWeight(.bold)
            ZStack {
                Image(systemName: "mappin.circle")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 40, height: 40)
                    .cornerRadius(10)
                    .foregroundColor(Color.white)
            }
            .padding(5)
            .background {
                Circle()
                    .foregroundColor(color)
            }
            .cornerRadius(10)
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(color)
                .frame(width: 20, height: 20)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -6)
                .padding(.bottom, 40)
        }
    }
}
