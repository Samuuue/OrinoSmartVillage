//
//  SideMenu.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 06/10/22.
//

import SwiftUI
import WebKit

struct SideMenu: View {
    @Binding var isSidebarVisible: Bool
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.7
    
    struct MenuItem: Identifiable {
        var id: Int
        var icon: String
        var label: String
    }
    
    var primaryAction: [MenuItem] = [
        MenuItem(id:4001, icon: "info.circle", label: String(localized: "label su di noi menu")),
        MenuItem(id:4002, icon: "envelope", label: String(localized: "label contattaci menu"))
    ]
    
    var settingAction: [MenuItem] = [
        MenuItem(id:4003, icon: "gear",  label: String(localized: "label impostazioni menu"))
    ]
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.6))
            .opacity(isSidebarVisible ? 1 : 0)
            .animation(.easeInOut.delay(0.2), value: isSidebarVisible)
            .onTapGesture {
                isSidebarVisible.toggle()
            }
            content
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        HStack(alignment: .top) {
            ZStack(alignment: .top) {
                Color("backgroud-menu")
                
                VStack {
                    
                    HStack {
                        Image("logo-comune-menu")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .background(Color("backgroud-menu"))
                            .clipShape(Circle())
                            .padding(.leading, 10.0)
                        
                        Text("OrinoSmartVillage")
                            .fontWeight(.bold)
                            .font(.system(size: 20.0))
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding(.top, 70.0)
                    
                    VStack() {
                        MenuLinks(items: primaryAction)
                    }
                    .padding(.top, 20.0)
                    
                    Spacer()
                    
                    Divider()
                    
                    MenuLinks(items: settingAction)
                        .padding(.bottom, 10.0)
                }
            }
            .frame(width: sideBarWidth)
            .offset(x: isSidebarVisible ? 0 : -sideBarWidth)
            .animation(.default, value: isSidebarVisible)
            .cornerRadius(10)

            Spacer()
        }
    }

    struct MenuLinks: View {
        var items: [MenuItem]
        var body: some View {
            VStack( spacing: 30) {
                ForEach(items) { item in
                    HStack {
                        menuLink(icon: item.icon, label: item.label)
                        Spacer()
                    }
                }
            }
            .padding(.vertical, 14)
            .padding(.leading, 8)
        }
    }
    
    struct menuLink: View {
        var icon: String
        var label: String
        var body: some View {
            NavigationLink(destination: {
                if(label == String(localized: "label su di noi menu")) {
                    InfoAboutUs()
                } else if(label == String(localized: "label contattaci menu")) {
                    ContactUsView()
                } else if(label == String(localized: "label impostazioni menu")) {
                    SettingView()
                }
            }, label: {
                HStack {
                    Image(systemName: icon)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.gray)
                        .padding(.trailing, 18)
                    Text(label)
                        .foregroundColor(.black)
                        .font(.body)
                }
            })
        }
    }
}

