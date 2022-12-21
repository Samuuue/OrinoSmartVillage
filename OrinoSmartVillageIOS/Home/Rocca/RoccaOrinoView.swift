//
//  RoccaOrinoView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 26/10/22.
//

import SwiftUI

struct RoccaOrinoView: View {
    
    @State private var showWebView = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            Image("image-rocca-orino")
                .resizable()
                .scaledToFit()
                .cornerRadius(15.0)
                .padding(.horizontal, 16.0)
            
            Text(LocalizedStringKey("Label RoccaOrino"))
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding([.top, .leading, .trailing], 20.0)
            
            Button("Maggiori informazioni"){
                showWebView.toggle()
            }
            NavigationLink(destination: PanoramicImage(path: "orino-360/R0010056_20221020103956.jpg").ignoresSafeArea().padding(.bottom), label: {
                Image("360-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80.0, height: 80.0)
                    .padding(.top, 20.0)
            })
            Button {
                openMap()
            } label: {
                HStack {
                    Image(systemName: "map")
                        .foregroundColor(Color("color-map-home"))
                        .padding(.trailing, 5.0)
                        .padding([.leading, .vertical], 7.0)
                    Text(LocalizedStringKey("MostraSuMappa"))
                        .font(.title3)
                        .foregroundColor(Color("color-map-home"))
                        .padding([.trailing, .vertical], 7.0)
                }
                .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color("color-map-home"), lineWidth: 1)
                    )
                .padding(.top, 40)
            }
            Spacer()
        }
        .sheet(isPresented: $showWebView, content: {
            Display(url: URL(string: "https://www.orinosmartvillage.it/place/la-rocca/")!)
                .overlay(closeButton, alignment: .topTrailing)
        })
        .navigationTitle("Rocca di Orino")
    }
    
    func openMap() {
        UIApplication.shared.open(URL(string: "https://maps.apple.com/?address=Via%20Aspromonte%202,%2021030%20Orino%20VA,%20Italy&auid=6409414801488580007&ll=45.887589,8.728205&lsp=9902&q=Rocca%20di%20Orino")!)
    }
}

extension RoccaOrinoView {
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

struct RoccaOrinoView_Previews: PreviewProvider {
    static var previews: some View {
        RoccaOrinoView()
    }
}
