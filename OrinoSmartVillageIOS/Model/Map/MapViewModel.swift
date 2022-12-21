//
//  MapViewModel.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 06/10/22.
//

import SwiftUI
import MapKit
import FirebaseDatabase
import FirebaseDatabaseSwift

class MapViewModel: ObservableObject {
    
    var ref: DatabaseReference!
    
    @Published var locations: [Location] = []

    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
    
    @Published var showLocationList: Bool = false
    
    @Published var sheetLocation: Location? = nil
    
    init() {
        self.mapLocation = Location(name: "Orino", description: "Città di Orino", latitude: 45.885992, longitude: 8.720602)
        updateMapRegion(location: mapLocation)
        readLocation()
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
                span: mapSpan)
        }
    }
    
    func toogleLocationList() {
        withAnimation(.easeInOut) {
            showLocationList = !showLocationList
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    
    func readLocation() {
        ref = Database.database().reference()
        var array: [LocationToFirebase] = []
        ref.child("location").observe(.value) { parentSnapshot in
            guard let children = parentSnapshot.children.allObjects as? [DataSnapshot] else {
                //incase not it
                return
                }
            array = children.compactMap({ snapshot in
                return try? snapshot.data(as: LocationToFirebase.self)
            })
            array.forEach { location in
                var location = Location(name: location.name, description: location.description, latitude: location.latitude, longitude: location.longitude)
                self.locations.append(location)
            }
        }
    }
}
