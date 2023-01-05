//
//  TemplateCantine.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 15/11/22.
//

import SwiftUI

struct TemplateCantine: View {
    
    let image: String
    let title: String
    let description: [String]
    let url: URL
    
    @State var showWebView = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .center, spacing: 20.0) {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(15.0)
                        .padding(.horizontal, 16.0)
                    
                    ForEach(description, id: \.self) { string in
                        Text(LocalizedStringKey(string))
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16.0)
                    }
                    Button(action: {showWebView.toggle()}, label: {
                        Text("Maggiori informazioni..")
                    })
                    
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $showWebView, content: {
            Display(url: url)
                .overlay(closeButton, alignment: .topTrailing)
        })
        .navigationTitle(title)
    }
}

extension TemplateCantine {
    private var closeButton: some View {
        Button(action: {
            showWebView.toggle()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(10)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        })
    }
}

