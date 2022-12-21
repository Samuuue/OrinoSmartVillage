//
//  LocationViewList.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 07/10/22.
//

import SwiftUI

struct LocationViewList: View {
    
    @EnvironmentObject private var locations: MapViewModel
    
    let color = Color("background-header-map")
    
    var body: some View {
        List {
            ForEach(locations.locations) { num in
                Button(action: {
                    locations.showNextLocation(location: num)
                }, label: {
                    ListRow(num: num)
                })
                .padding(.vertical, 4.0)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

extension LocationViewList {
    private func ListRow(num: Location) -> some View {
        HStack {
            Image(systemName: "mappin.circle")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 45.0, maxHeight: 45.0)
                .cornerRadius(20.0)
                .foregroundColor(color)
                .padding(.trailing,10.0)
            VStack{
                Text(num.name)
                    .fontWeight(.bold)
            }
        }
    }
}
