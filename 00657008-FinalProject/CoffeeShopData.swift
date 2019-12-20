//
//  CoffeeShopData.swift
//  00657008-FinalProject
//
//  Created by User16 on 2019/12/15.
//  Copyright © 2019 00657008. All rights reserved.
//

import Foundation

struct Shop: Codable,Identifiable{
    var id: UUID
    var name: String
    var address: String
    /*var wifi: Int
    var seat: Int
    var quiet: Int
    var tasty: Int
    var cheap: Int
    var latitude: Double
    var longitude: Double
    var url: URL?
    var limited_time: String?
    var socket: String?
    var standing_desk: String?
    var open_time: String?*/
}

struct ShopResults: Codable {
    var resultCount: Int
    var results: [Shop]
}
