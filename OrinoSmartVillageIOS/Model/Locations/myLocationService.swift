//
//  myLocationService.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 13/10/22.
//

import Foundation
import SwiftUI
import MapKit

class myLocationService: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    
    @Published var myPosition: CLLocation? = CLLocation(latitude: 100.0, longitude: 100.0)
    
    func checkIfLocationServiceEnbaled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.startUpdatingLocation()
        } else {
            print("Error")
        }
    }
        
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
                
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            locationManager.requestAlwaysAuthorization()
        case .denied:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            myPosition = locationManager.location
        @unknown default:
            break
        }
    }
        
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.myPosition = location
    }
}
