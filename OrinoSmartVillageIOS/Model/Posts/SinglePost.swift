//
//  SinglePost.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 27/10/22.
//

import Foundation

struct SinglePost: Identifiable {
    var id: Int
    var Status: String
    var Title: String
    var Content: String
    var Excerpt: String
    var hasImage: Bool
    var Link: URL
}
