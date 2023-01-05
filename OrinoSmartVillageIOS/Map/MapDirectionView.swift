//
//  MapDirectionView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 10/11/22.
//

import SwiftUI
import MapKit

struct MapDirectionView: View {
    
    let direction: CLLocationCoordinate2D
    
    let transportType: MKDirectionsTransportType
    
    @EnvironmentObject private var myDMVM: DirectionsMapViewModel
    
    @EnvironmentObject private var networkManager: NetworkMenager
    
    @State private var showDirections: Bool = false
    
    var body: some View {
        ZStack {
            if(networkManager.isConnected == false) {
                ErrorConnectionView()
            } else if(networkManager.isConnected == true) {
                ZStack {
                    MapViewofDirection(directions: $myDMVM.directionsString, direction: direction, transportType: transportType)
                        .ignoresSafeArea()
                    VStack {
                        Spacer()
                        buttonDirection
                            .padding(.bottom, 15.0)
                    }
                }
                .ignoresSafeArea()
                .sheet(isPresented: $showDirections, content: {
                    VStack(alignment: .center) {
                        Text(LocalizedStringKey("TitoloDirezioni"))
                            .font(.title)
                            .padding()
                        Divider()
                            .background(Color("background-header-map"))
                        List {
                            ForEach(myDMVM.directionsString, id: \.self) { direction in
                                Text(direction)
                                    .font(.headline)
                                    .padding()
                            }
                        }
                    }
                })
            }
        }
    }
}

extension MapDirectionView {
    private var buttonDirection: some View {
        HStack {
            Button(action: {
                self.showDirections.toggle()
            }, label: {
                Text("direzioni")
            })
            .padding(.horizontal, 150.0)
            .padding(.vertical)
        }
        .background(Color("background-header-map"))
        .cornerRadius(15.0)
        .shadow(color: .black ,radius: 12.0)
    }
}

struct MapViewofDirection: UIViewRepresentable {
    
    @EnvironmentObject private var myLM: myLocationService
    
    @EnvironmentObject private var myDMVM: DirectionsMapViewModel
    
    @Binding var directions: [String]
    
    let direction: CLLocationCoordinate2D
    
    let transportType: MKDirectionsTransportType
    
    typealias UIViewType = MKMapView
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: myLM.myPosition!.coordinate.latitude, longitude: myLM.myPosition!.coordinate.longitude),
                                        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        mapView.setRegion(region, animated: true)
        
        //Marker my position in real time
        let markerMyPosition = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: myLM.myPosition!.coordinate.latitude, longitude: myLM.myPosition!.coordinate.longitude))
        
        //Marker position of direction point
        let markerDirectionPosition = MKPlacemark(coordinate: direction)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: markerMyPosition)
        request.destination = MKMapItem(placemark: markerDirectionPosition)
        request.transportType = transportType
        
        let direction = MKDirections(request: request)
        direction.calculate { response, error in
            guard let route = response?.routes.first else { return }
            mapView.addAnnotations([markerMyPosition, markerDirectionPosition])
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                animated: true)
            myDMVM.directionsString = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
        }
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
}

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        renderer.lineWidth = 5
        return renderer
    }
}
