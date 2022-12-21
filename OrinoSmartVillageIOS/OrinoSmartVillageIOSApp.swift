//
//  OrinoSmartVillageIOSApp.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 02/10/22.
//

import SwiftUI
import AVFoundation
import Firebase

@main
struct OrinoSmartVillageIOSApp: App {
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    @AppStorage("NotifyIsActive") var NotifyIsActive: Bool = false
    
    @StateObject private var myMVM = MapViewModel()
    @StateObject private var myLM = myLocationService()
    @StateObject private var myImageCache = CacheImage()
    @StateObject private var myDMVM = DirectionsMapViewModel()
    @StateObject private var mySCVM = SplashScreenViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            if(mySCVM.isActive) {
                if(isOnboarding) {
                    OnboardingContainerView()
                } else {
                    DasboardingContainer()
                        .environmentObject(myMVM)
                        .environmentObject(myLM)
                        .environmentObject(myImageCache)
                        .environmentObject(myDMVM)
                        .environmentObject(mySCVM)
                }
            } else {
                SplashScreenView()
                    .environmentObject(mySCVM)
            }
        }
    }
}
