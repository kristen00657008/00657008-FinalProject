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
    var body: some View {
            ZStack{
                Button(action: {self.sheetOn = true}) {
                    ZStack{
                        Image("臺北")
                            .resizable()
                            .renderingMode(.original)
                            .scaledToFill()
                            .frame(width: 300, height:200)
                            .opacity(0.8)
                        Text("臺北")
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 85))
                    }
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .padding(20)
                }.zIndex(1)
                .offset(y:-250)
                .sheet(isPresented: self.$sheetOn) {
                    ShopList(urlStr: "https://cafenomad.tw/api/v1.2/cafes/taipei")
                }
                Button(action: {self.sheetOn = true}) {
                    CityRow(city:"臺中")
                }.zIndex(1)
                .sheet(isPresented: self.$sheetOn) {
                    ShopList(urlStr: "https://cafenomad.tw/api/v1.2/cafes/taichung")
                }
                Button(action: {self.sheetOn = true}) {
                    CityRow(city:"高雄")
                }.zIndex(1)
                .offset(y:250)
                .sheet(isPresented: self.$sheetOn) {
                    ShopList(urlStr: "https://cafenomad.tw/api/v1.2/cafes/kaohsiung")
                }
                Image("coffee").resizable().zIndex(0).opacity(0.8).scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            //.background()
            .edgesIgnoringSafeArea(.all)
            
        
    }
}

struct ChooseCity_Previews: PreviewProvider {
    static var previews: some View {
        ChooseCity()
    }
}
