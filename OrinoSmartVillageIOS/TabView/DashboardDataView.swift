//
//  DashboardDataView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 25/11/22.
//

import SwiftUI

struct DashboardDataView: View {
    var body: some View {
        ZStack {
            Display(url: URL(string: "https://www.google.it")!)
        }
    }
}

struct DashboardDataView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardDataView()
    }
}
