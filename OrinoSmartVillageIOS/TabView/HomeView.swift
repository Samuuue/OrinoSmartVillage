//
//  HomeView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 03/10/22.
//

import SwiftUI


struct HomeView: View {
    
    @StateObject var imageCarousell = ImagesCarousell()
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    if(imageCarousell.showCarousell) {
                        HStack(alignment: .center) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                MoviesCarousell(images: imageCarousell.images)
                            }
                            .padding(.horizontal, 20.0)
                        }
                    } else {
                        ProgressView()
                            .frame(width: 280, height: 200)
                    }
                    
                }
                Spacer()
                PlacesGrid()
                    .padding(.horizontal, 20.0)
                Spacer()
            }
        }
        .navigationTitle(LocalizedStringKey("Home"))
    }
}

struct MoviesCarousell: View {
    
    let images: [UIImage]
    
    var body: some View {
        HStack(){
            ForEach(images, id: \.self) { image in
                GeometryReader { proxy in
                    let scale = getScale(proxy: proxy)
                    VStack {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .clipped()
                                .cornerRadius(8)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(white: 0.4))
                                }
                                .shadow(radius: 4)
                        }
                    .scaleEffect(.init(width: scale, height: scale))
                }
                .frame(width: 280, height: 200)
            }
            Spacer()
                .frame(width: 10)
        }
    }
    
    func getScale(proxy: GeometryProxy) -> CGFloat {
        
        let midPoint: CGFloat = 250
        
        let  viewFrame = proxy.frame(in: CoordinateSpace.global)
        
        var scale: CGFloat = 1.0
        let deltaXAnimationThreshold: CGFloat = 100
        
        let diffFromCenter = abs(midPoint - viewFrame.origin.x - deltaXAnimationThreshold / 2)
        if diffFromCenter < deltaXAnimationThreshold {
            scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 500
        }
        return scale
    }
}

struct PlacesGrid: View {
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 130))
    ]
    
    var body : some View {
        LazyVGrid(columns: adaptiveColumns, spacing: 50) {
            NavigationLink(destination: ChiesaView(ripreseChiesa: [stringCard(label: "orino-360/R0010038_20221020094024.jpg"), stringCard(label: "orino-360/R0010041_20221020094232.jpg"), stringCard(label: "orino-360/R0010035_20221020093635.jpg")]), label: {
                SingleGrid(image: "chiese", label: "Chiese")
            })
            NavigationLink(destination: RoccaOrinoView(), label: {
                SingleGrid(image: "rocca", label: "Rocca di Orino")
            })
            NavigationLink(destination: CortiliView(ripreseCortili: [stringCard(label: "orino-360/R0010044_20221020095053.jpg"), stringCard(label: "orino-360/R0010046_20221020095229.jpg"), stringCard(label: "orino-360/R0010047_20221020095344.jpg"), stringCard(label: "orino-360/R0010050_20221020100729.jpg")]), label: {
                SingleGrid(image: "cortili", label: "Cortili")
            })
            NavigationLink(destination: CantineView(), label: {
                SingleGrid(image: "cantine", label: "Cantine")
            })
        }
    }
}

struct SingleGrid: View {
    
    let image: String
    let label: String
    
    var body: some View {
        ZStack {
            Rectangle()
                //.frame(width: 150, height: 150)
                .foregroundColor(Color("background-header-map"))
                .cornerRadius(30)
                .shadow(radius: 10)
            VStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 110)
                Text(label)
                    .font(.system(size: 13))
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 15.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
