//
//  ShopRow.swift
//  00657008-FinalProject
//
//  Created by User16 on 2019/12/15.
//  Copyright © 2019 00657008. All rights reserved.
//

import SwiftUI

struct ShopRow: View {
    var shop: Shop
    var currentDistrict : String
    /*func ifDistrict() -> Bool {
        /*temp = address.components(separatedBy: "市")
        city = String(temp[0].suffix(2)) + "市"*/
        
        if(self.currentDistrict == "選擇區域"){
            return true
        }
        else {
            let address = self.shop.address
            var temp: [String]
            var zone: String
            temp = address.components(separatedBy: "區")
            zone = String(temp[0].suffix(2)) + "區"
            if (zone == self.currentDistrict){
                return true
            }
            else{
                return false
            }
        }
    }*/
    
    var body: some View {
        VStack(alignment: .leading) {
            //if(ifDistrict()){
                Text(shop.name)
                    .bold()
                Text(shop.address)
            //}
        }
    }
}

struct ShopRow_Previews: PreviewProvider {
    static var previews: some View {
        ShopRow(shop: Shop( id: UUID(),
                            name: "123",
                            address: "456"
                            /*wifi: 0,
                            seat: 0,
                            quiet: 0,
                            tasty: 0,
                            cheap: 0,
                            latitude: 0,
                            longitude: 0,
                            url: URL(string: "https://cafenomad.tw/api/v1.2/cafes/taipei"),
                            limited_time: "",
                            socket: "",
                            standing_desk: "",
                            open_time: ""*/ )
            ,currentDistrict: "123"
        )
    }
}
