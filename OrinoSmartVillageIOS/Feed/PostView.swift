//
//  PostView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 01/11/22.
//

import SwiftUI

struct PostView: View {
    
    @State var post: SinglePost
    
    
    var body: some View {
        Button(action: {
            UIApplication.shared.open(URL(string: "https://www.orinosmartvillage.it")!)
        }, label: {
            VStack {
                VStack {
                    Text(post.Title)
                        .fontWeight(.bold)
                        .font(.system(size: 20.0))
                        .foregroundColor(Color("color-text-feed"))
                        .multilineTextAlignment(.center)
                        .italic()
                        .shadow(color: Color("background-header-map"), radius: 15.0)
                    Divider()
                    Text(post.Content)
                        .font(.headline)
                        .foregroundColor(Color("color-text-feed"))
                        .multilineTextAlignment(.center)
                        .shadow(color: Color("background-header-map"), radius: 15.0)
                    Divider()
                    Text(post.Excerpt)
                        .font(.subheadline)
                        .foregroundColor(Color("color-text-feed"))
                        .multilineTextAlignment(.center)
                        .shadow(color: Color("background-header-map"), radius: 15.0)
                    Divider()
                }
                .shadow(radius: 15.0)
                .padding(25.0)
                .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color("color-text-feed"), lineWidth: 1)
            )
                HStack(alignment: .bottom) {
                    Text(post.Status)
                        .font(.system(size: 10.0))
                        .fontWeight(.light)
                        .foregroundColor(Color.black)
                        .italic()
                        .padding(.leading, 20.0)
                    Spacer()
                }
            }
            .padding(.horizontal, 25.0)
        })
    }
}
