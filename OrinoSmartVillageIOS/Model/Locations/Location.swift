//
//  Location.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 19/10/22.
//

import Foundation
import CoreLocation

struct Location: Decodable, Identifiable, Equatable {
    let id = UUID().uuidString
    let name: String
    let description: String
    let latitude: Double
    let longitude: Double
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
