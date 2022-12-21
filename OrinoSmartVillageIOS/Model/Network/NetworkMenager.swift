//
//  NetworkMenager.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 11/11/22.
//

import Foundation
import Network

class NetworkMenager: ObservableObject {
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Network Manager")
    
    @Published var isConnected = true
    @Published var isPresented = false

    init() {
        monitor.pathUpdateHandler = { path in
           DispatchQueue.main.sync {
               self.isConnected = path.status == .satisfied
               self.isPresented = !self.isConnected
           }
        }
        monitor.start(queue: queue)
    }
}
