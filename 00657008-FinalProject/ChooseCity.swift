//
//  ChooseCity.swift
//  00657008-FinalProject
//
//  Created by User22 on 2019/12/22.
//  Copyright © 2019 00657008. All rights reserved.
//

import SwiftUI
import PartialSheet

struct ChooseCity: View {
    @State private var sheetOn = false
    var citiesChi: [String] = ["基隆","臺北", "臺中", "高雄"]
    var citiesEng: [String] = ["keelung","taipei", "taichung", "kaohsiung"]
    @State private var buttonIndex:Int = 0
    var body: some View {
        ZStack{
            ScrollView {
                VStack{
                    ForEach(0..<4) {(index) in
                        Button(action: {self.sheetOn = true
                            self.buttonIndex = index
                        }) {
                            ZStack{
                                Image(self.citiesChi[index])
                                    .resizable()
                                    .renderingMode(.original)
                                    .scaledToFill()
                                    .frame(width: 300, height:200)
                                    .opacity(0.8)
                                Text(self.citiesChi[index])
                                    .foregroundColor(Color.white)
                                    .font(Font.system(size: 85))
                            }
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            .padding(20)
                        }
                        .sheet(isPresented: self.$sheetOn) {
                            ShopList(urlStr: "https://cafenomad.tw/api/v1.2/cafes/"+self.citiesEng[self.buttonIndex],districts: Districts[self.buttonIndex])
                        }
                    }
                }
            }.zIndex(1).frame(height:750)
            Image("coffee").resizable().zIndex(0).opacity(0.8).scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
        }
    }
}

struct ChooseCity_Previews: PreviewProvider {
    static var previews: some View {
        ChooseCity()
    }
}
