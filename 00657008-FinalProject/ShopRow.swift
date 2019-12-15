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
    /*var zone: String
    init() {
       
        
    }*/
    var body: some View {
        VStack(alignment: .leading) {
            Text(shop.name)
                .bold()
            Text(shop.address)
        }
    }
}

struct ShopRow_Previews: PreviewProvider {
    static var previews: some View {
        ShopRow(shop: Shop(
                            id: UUID(),
                            name: "",
                            address: ""
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
                            open_time: ""*/
                        )
                )
        }
}
