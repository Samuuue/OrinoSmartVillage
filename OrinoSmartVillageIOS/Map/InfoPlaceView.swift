//
//  InfoPlaceView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 14/10/22.
//

import SwiftUI
import  MapKit

struct InfoPlaceView: View {
    
    @EnvironmentObject private var locations: MapViewModel
    
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    title
                    Divider()
                    description
                    Divider()
                    miniMap
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topTrailing)
    }
}

extension InfoPlaceView {
    private var title: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.title)
                .fontWeight(.semibold)
        }
    }
    
    private var description: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private var miniMap: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01))),
            annotationItems: [location]) { location in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                        MarkerMapView(location: location)
                        .shadow(radius: 10)
            }
           }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)
    }
    
    private var backButton: some View {
        Button(action: {
            locations.sheetLocation = nil
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        })
    }
}
