//
//  DasboardingContainer.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 04/10/22.
//

import SwiftUI

struct DasboardingContainer: View {
    
    @StateObject var showMenuService = MenuService()
    
    @StateObject var networkMenager = NetworkMenager()
    
    @AppStorage("ColorIndex") private var indexTheme: Int = 1
    
    private var selectetTheme: ColorScheme? {
        if(indexTheme == 1) {
            return .light
        } else {
            if(indexTheme == 2) {
                return .dark
            }
        }
        return nil
    }      
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    TabView() {
                        NavigationView {
                            ZStack{
                                HomeView()
                            }
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button {
                                        showMenuService.showMenu.toggle()
                                    } label: {
                                        Image("filemenu.and.selection")
                                            .foregroundColor(Color.black)
                                    }
                                }
                            }
                        }
                        .tabItem {
                            Image(systemName: "house")
                            Text(LocalizedStringKey("Home"))
                        }
                        NavigationView {
                            ScannView()
                        }
                        .tabItem {
                            Image(systemName: "qrcode.viewfinder")
                            Text(LocalizedStringKey("Scann qr"))
                        }
                        NavigationView {
                            ZStack {
                                SFSafariView(url: URL(string: "https://orino-smart-village.web.app/index.html")!)
                                    .ignoresSafeArea()
                                VStack() {
                                    Text(LocalizedStringKey("AR Title"))
                                        .fontWeight(.semibold)
                                        .font(.system(size: 22.5))
                                        .foregroundColor(Color.black)
                                        .background(Color.white)
                                        .padding(.top, 5.0)
                                    Spacer()
                                }
                            }
                        }
                        .tabItem {
                            Image(systemName: "mappin.and.ellipse")
                            Text(LocalizedStringKey("Luoghi"))
                        }
                        NavigationView {
                            MapView()
                        }
                        .tabItem {
                            Image(systemName: "map")
                            Text(LocalizedStringKey("Mappa"))
                        }
                        NavigationView {
                            FeedView()
                        }
                        .tabItem {
                            Image(systemName: "newspaper")
                            Text(LocalizedStringKey("Notizie"))
                        }
                    }
                    SideMenu(isSidebarVisible: $showMenuService.showMenu)
                }
            }
            .preferredColorScheme(selectetTheme)
        }
        .alert(isPresented: $networkMenager.isPresented, content: {
            Alert(title: Text(LocalizedStringKey("AlertTitle")),
                  message: Text(LocalizedStringKey("AlertMessage")),
                  primaryButton: .default(Text(LocalizedStringKey("AlertDefault"))),
                  secondaryButton: .default(Text(LocalizedStringKey("AlertGo")),
                  action: {
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                print("Settings opened: \(success)") // Prints true
                            }
                        )
                    }
            }))
        })
        .environmentObject(networkMenager)
    }
}

struct DasboardingContainer_Previews: PreviewProvider {
    static var previews: some View {
        DasboardingContainer()
    }
}
