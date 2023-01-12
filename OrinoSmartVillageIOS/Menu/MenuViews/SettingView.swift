//
//  SettingView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 06/10/22.
//

import SwiftUI

struct SettingView: View {
    
    @AppStorage("systemNameVal") private var systemTheme: Int = SchemeType.allCases.first!.rawValue
    @AppStorage("ColorIndex") private var indexTheme: Int = 1
    @AppStorage("NotifyIsActive") var NotifyIsActive: Bool = false
    @State private var showMore = false

     var selectedScheme: ColorScheme? {
        guard let theme = SchemeType(rawValue: systemTheme) else { return nil }
        switch theme {
        case .light:
            indexTheme = 1
            return .light
        case .dark:
            indexTheme = 2
            return .dark
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack {
                        Divider()
                        VStack {
                            HStack {
                                Text(LocalizedStringKey("Tema"))
                                    .font(.system(size: 20.0))
                                    .padding(.leading, 40.0)
                                Spacer()
                                Picker(selection: $systemTheme) {
                                    ForEach(SchemeType.allCases) { item in
                                        Text(item.title)
                                            .tag(item.rawValue)
                                    }
                                } label: {
                                    Text("Pick a item")
                                }
                                .padding(.trailing, 80.0)
                                .background(Color("background-picker"), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                            }
                            .padding(.top, 20.0)
                        }
                        .padding(.top, 30.0)
                        Divider()
                    }

                    VStack(spacing: 15.0){
                        Text(LocalizedStringKey("title-info-condizioni"))
                            .multilineTextAlignment(.leading)
                            .font(.title)
                        
                        VStack {
                            Text(LocalizedStringKey("info-condizioni"))
                                .font(.headline)
                                if showMore {
                                    Text(LocalizedStringKey("info-condizioni-expanded"))
                                        .font(.subheadline)
                                        .padding(.top, 3.0)
                                    Link(String(localized: "title-info-condizioni"), destination: URL(string: "https://www.google.it")!)
                                        .padding(.vertical, 8.0)
                                }
                            Button(action: {
                                self.showMore.toggle()
                            }) {
                                Text(self.showMore ? "Mostra meno" : "Leggi di più")
                                    .padding(.vertical, 5.0)
                            }
                        }
                        .padding(.horizontal, 15.0)
                    }
                    .padding(.top, 100.0)
                    Spacer()
                }
            }
        }
        .navigationTitle(String(localized: "Impostazioni menu"))
        .preferredColorScheme(selectedScheme)
    }
}

enum SchemeType: Int, Identifiable, CaseIterable {

    var id: Self { self }
    case light
    case dark
}

extension SchemeType {
    var title: String {
        switch self {
        case .dark:
            return String(localized: "Scuro")
        case .light:
            return String(localized: "Chiaro")
        }
    }
}
