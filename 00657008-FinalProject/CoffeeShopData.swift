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
    var wifi: Double
    var seat: Double
    var quiet: Double
    var tasty: Double
    var cheap: Double
    var latitude: String
    var longitude: String
    var open_time: String?
    var socket: String?
    var standing_desk: String?
    var limited_time: String?
    //var url: URL?
    
    
    
    
}

struct ShopResults: Codable {
    var resultCount: Int
    var results: [Shop]
}
