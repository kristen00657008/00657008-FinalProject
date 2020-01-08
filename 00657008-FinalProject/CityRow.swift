//
//  CityRow.swift
//  00657008-FinalProject
//
//  Created by User22 on 2019/12/22.
//  Copyright © 2019 00657008. All rights reserved.
//

import SwiftUI

struct CityRow: View {
    var city: String
    var body: some View {
        GeometryReader { (geometry) in
            ZStack{
                Image(self.city)
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFill()
                    .frame(width: geometry.size.width * 300 / 414, height:geometry.size.height * 200 / 414)
                    .opacity(0.7)
                Text(self.city)
                    .foregroundColor(Color.white)
                    .font(Font.system(size: 85))
            }
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding(20)
        }
        
    }
}

struct CityRow_Previews: PreviewProvider {
    static var previews: some View {
        CityRow(city: "臺北")
    }
}
