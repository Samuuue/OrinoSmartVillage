//
//  CardPlaceView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 11/10/22.
//

import SwiftUI
import CoreLocationUI
import MapKit


struct CardPlaceView: View {
    
    let location: Location
    
    @EnvironmentObject private var locations: MapViewModel
    
    @EnvironmentObject private var myLM: myLocationService
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 16) {
                titleCard
            }
            VStack(spacing: 20) {
                moreinfoCard
                mylocationCard
            }
        }
        .padding([.top, .bottom, .trailing], 20.0)
        .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
        )
        .cornerRadius(10)
    }
}

extension CardPlaceView {
    private var imageCard: some View {
        ZStack {
            Image(systemName: "mappin.circle")
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 120, height: 120)
                .cornerRadius(10)
                .foregroundColor(Color.white)
            
        }
        .padding(8)
        .background {
            Circle()
                .foregroundColor(Color("background-header-map"))
        }
        .cornerRadius(10)
    }
    
    private var titleCard: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title)
        }
        .padding(.leading, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var moreinfoCard: some View {
        Button {
            locations.sheetLocation = location
        } label: {
            Text(LocalizedStringKey("Più info"))
                .fontWeight(.medium)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 150, height: 30)
        }
        .padding(9)
        .background(Color("background-header-map"))
        .cornerRadius(5)
    }
    
    private var mylocationCard: some View {
        HStack(spacing: 30) {
            Text(String(Int(myLM.myPosition!.distance(from: CLLocation(latitude: location.latitude, longitude: location.longitude)))) + " m")
                .font(.system(size: 10))
            
            MenuTypeOfDirection(direction: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                .font(.headline)
        }
    }
}

struct MenuTypeOfDirection: View {
    
    @EnvironmentObject private var myDMVM: DirectionsMapViewModel
    
    var direction: CLLocationCoordinate2D
    
    var body: some View {
        Menu("Portami lì..") {
            Button("Automobile") {
                self.myDMVM.transportType = .automobile
                self.myDMVM.direction = direction
                self.myDMVM.showDirection.toggle()
            }
            Button("Camminando") {
                self.myDMVM.transportType = .walking
                self.myDMVM.direction = direction
                self.myDMVM.showDirection.toggle()
            }
        }
    }
}


