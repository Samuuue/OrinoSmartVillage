//
//  DirectionsMapViewModel.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 10/11/22.
//

import Foundation
import MapKit

class DirectionsMapViewModel: ObservableObject {
    
    @Published var showDirection: Bool = false
    
    @Published var transportType: MKDirectionsTransportType = .automobile
    
    @Published var direction: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 100.0, longitude: 100.0)
    
    @Published var directionsString: [String] = []
    
}
