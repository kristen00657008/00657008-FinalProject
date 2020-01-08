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
    
    var body: some View {
        GeometryReader { (geometry) in
            VStack(alignment: .center) {
                Text(self.shop.name)
                    .bold()
                Text(self.shop.address)
            }
            .frame(width: geometry.size.width * 330 / 414)
            .background(Color.yellow)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        
    }
}

struct ShopRow_Previews: PreviewProvider {
    static var previews: some View {
        ShopRow(shop: Shop( id: UUID(),
                            name: "123",
                            address: "456",
                            wifi: 0,
                            seat: 0,
                            quiet: 0,
                            tasty: 0,
                            cheap: 0,
                            latitude: "0",
                            longitude: "0",
                            //url: URL(string: "https://cafenomad.tw/api/v1.2/cafes/taipei"),
                            open_time: "",
                            socket: "",
                            standing_desk: "",
                            limited_time: "" )
        )
    }
}
