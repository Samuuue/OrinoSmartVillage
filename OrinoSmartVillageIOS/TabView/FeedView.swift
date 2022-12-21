//
//  FeedView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 19/10/22.
//

import SwiftUI


struct FeedView: View {
    
    @StateObject var myVM = FeedViewModel()
    
    @EnvironmentObject private var networkManager: NetworkMenager
    
    var body: some View {
        ZStack {
            if(networkManager.isConnected == false) {
                ErrorConnectionView()
            }
            if(networkManager.isConnected == true) {
                if(myVM.post.isEmpty) {
                    ProgressView()
                }
                list
            }
            
        }
    }
}

extension FeedView {
    
    var list: some View {
        ScrollView {
            ForEach(myVM.post, id: \.id) { post in
                PostView(post: post)
                    .padding(.bottom, 15.0)
            }
        }
        .navigationTitle("Feed")
        .onAppear {
            myVM.fetch(url: "https://www.orinosmartvillage.it/wp-json/wp/v2/posts", cerca: false)
        }
        .refreshable {
            myVM.fetch(url: "https://www.orinosmartvillage.it/wp-json/wp/v2/posts", cerca: true)
        }
    }
}


