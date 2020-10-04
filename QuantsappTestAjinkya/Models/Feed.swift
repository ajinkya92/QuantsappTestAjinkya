//
//  Feed.swift
//  QuantsappTestAjinkya
//
//  Created by apple on 04/10/20.
//

import Foundation

struct Feed: Codable {
    let feed: [FeedDetails]
}

struct FeedDetails: Codable {
    let id: Int
    let name: String
    let image: String?
    let status: String
    let profilePic: String
    let timeStamp: String
    let url: String?
}
