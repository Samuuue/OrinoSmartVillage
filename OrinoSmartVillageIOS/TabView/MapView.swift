//
//  MapView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 06/10/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @EnvironmentObject private var locations: MapViewModel
    
    @EnvironmentObject private var myLM: myLocationService
    
    @EnvironmentObject private var myDMVM: DirectionsMapViewModel
    
    @EnvironmentObject private var networkManager: NetworkMenager
    
    var body: some View {
        ZStack {
            if(networkManager.isConnected == false) {
                ErrorConnectionView()
            } else if(networkManager.isConnected == true){
                ZStack {
                    map
                    VStack(spacing: 0) {
                        header
                            .padding()
                        Spacer()
                        card
                    }
                }
                .padding(.bottom)
                .sheet(item: $locations.sheetLocation, onDismiss: nil) { location in
                    InfoPlaceView(location: location)
                }
                .sheet(isPresented: $myDMVM.showDirection) {
                    MapDirectionView(direction: myDMVM.direction, transportType: myDMVM.transportType)
                        .overlay(alignment: .topTrailing, content: {
                            Button(action: {
                                myDMVM.showDirection.toggle()
                            }, label: {
                                Image(systemName: "xmark")
                                    .font(.headline)
                                    .padding(10)
                                    .foregroundColor(.primary)
                                    .background(.thickMaterial)
                                    .cornerRadius(10)
                                    .shadow(radius: 4)
                                    .padding()
                            })
                        })
                }
            }
        }
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//            .environmentObject(MapViewModel())
//    }
//}

extension MapView {
    
    private var header: some View {
        VStack {
            Button(action: locations.toogleLocationList) {
                Text(locations.mapLocation.name)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 50.0)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: locations.mapLocation)
                    .background(Color("background-header-map"))
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees:
                                                    locations.showLocationList ? 180 : 0))
            }
        }
            if locations.showLocationList {
                LocationViewList()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10.0)
        .shadow(color: Color.black.opacity(0.3) ,radius: 20.0, x: 0, y: 15)
    }
    
    private var map: some View {
        Map(coordinateRegion: $locations.mapRegion,
            showsUserLocation: true,
            annotationItems: locations.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                MarkerMapView(location: location)
                    .scaleEffect(locations.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 15)
                    .onTapGesture {
                        locations.showNextLocation(location: location)
                    }
            }
        })
            .ignoresSafeArea()
            .onAppear {
                myLM.checkIfLocationServiceEnbaled()
            }
    }
    
    private var card: some View {
        ZStack {
            ForEach(locations.locations) { loc in
                if locations.mapLocation == loc {
                    CardPlaceView(location: loc)
                        .shadow(color: Color.black.opacity(0.5), radius: 20)
                        .padding(10)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}
