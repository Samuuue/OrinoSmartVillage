//
//  LocationToFirebase.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 06/12/22.
//

import Foundation
struct LocationToFirebase: Encodable, Decodable {
    let description: String
    let latitude: Double
    let longitude: Double
    let name: String
}
