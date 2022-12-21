//
//  CantineView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 30/10/22.
//

import SwiftUI

struct CantineView: View {
    var body: some View {
        ListItem()
            .padding()
            .navigationTitle("Cantine")
    }
}

struct CantineView_Previews: PreviewProvider {
    static var previews: some View {
        CantineView()
    }
}

struct CantineItem: View {
    
    let name: String
    let image: String
    
    var body: some View {
        ZStack {
            VStack() {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15.0)
                    .shadow(radius: 12.0)
                    .padding([.horizontal, .top], 15.0)
                    .padding(.vertical, 10.0)
                Text(name)
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .padding(.bottom, 15.0)
            }
        }
        .background(Color("background-header-map"))
        .cornerRadius(15.0)
        .shadow(radius: 12.0)
    }
}

struct ListItem: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 25.0) {
                NavigationLink(destination: TemplateCantine(image: "burgett", title: "Il Burgett di Ratt", description: ["DescrizioneBurgett"], url: URL(string: "https://www.orinosmartvillage.it/place/burghett-rat/")!)) {
                    CantineItem(name: "Il Burgett di Ratt", image: "burgett")
                        .padding(.horizontal, 40.0)
                }
                NavigationLink(destination: TemplateCantine(image: "cantina-gesa", title: "Cantina du la Gesa", description: ["DescrizioneGesaTerra", "DescrizioneGesaLegno"], url: URL(string: "https://www.orinosmartvillage.it/place/cantina-du-la-gesa/")!)) {
                    CantineItem(name: "Cantina du la Gesa", image: "cantina-gesa")
                        .padding(.horizontal, 40.0)
                }
                NavigationLink(destination: TemplateCantine(image: "cantina-mariana", title: "Cantina du la Mariana", description: ["DescrizioneMariana"], url: URL(string: "https://www.orinosmartvillage.it/place/cantina-mariana/")!)) {
                    CantineItem(name: "Cantina du la Mariana", image: "cantina-mariana")
                        .padding(.horizontal, 40.0)
                }
                NavigationLink(destination: TemplateCantine(image: "fael", title: "Cantina du la Fael", description: ["DescrizioneFael"], url: URL(string: "https://www.orinosmartvillage.it/place/cantina-dul-fael/")!)) {
                    CantineItem(name: "Cantina du la Fael", image: "fael")
                        .padding(.horizontal, 40.0)
                }
            }
        }
    }
}
