//
//  SplashScreenView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 19/11/22.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    @EnvironmentObject var myLSVM: SplashScreenViewModel
    
    let backgroundView = LinearGradient(
        colors: [Color("lunch-screen-background")],
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        if(myLSVM.isActive) {
            DasboardingContainer()
        } else {
            ZStack {
                backgroundView
                VStack {
                    Image("logo-lunch")
                    Text("Orino Smart Vilagge")
                        .font(Font.custom("Baskerville-Bold", size: 26))
                        .foregroundColor(Color("color-label-lunch-screen"))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.5 )) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    myLSVM.isActive = true
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
