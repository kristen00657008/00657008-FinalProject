//
//  ShopList.swift
//  00657008-FinalProject
//
//  Created by User16 on 2019/12/15.
//  Copyright © 2019 00657008. All rights reserved.
//

import SwiftUI
import PartialSheet

struct ShopList: View {
    
    @State private var shops = [Shop]()
    @State private var selectedIndex = 0
    @State private var currentWifi = ""
    @State private var currentDistrict = ""
    @State private var currentPrice = ""
    @State private var showChooseDistrict = false
    @State private var showChooseWifi = false
    @State private var showChoosePrice = false
    var districts = ["中正區","大同區","中山區","松山區","大安區","萬華區","信義區","士林區","北投區","內湖區","南港區","文山區"]
    
    func fetchShops() {
        let urlStr = "https://cafenomad.tw/api/v1.2/cafes/taipei"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                if let data = data, let shop = try? decoder.decode([Shop].self, from: data) {
                    self.shops = shop
                }
            }.resume()
            
        }
    }
    
    private var sheet: ActionSheet {
        
        let action = ActionSheet(
            title: Text("是否需要Wifi").font(Font.system(size: 30)),
            message: Text("是否需要Wifi"),
            buttons: [
                .default(Text("需要"), action: { print("hello") }),
                .destructive(Text("不需要"), action: { print("hello") }),
                .cancel(Text("不重要"), action: { print("hello") }),
            ]
        )
        
        return action
    }
    
    var body: some View {
        
        NavigationView{
            VStack {
                Button(action: {
                    self.showChooseDistrict = true
                }) {Text("選擇區域").bold()}
                .offset(x: -0, y: -250)
                .partialSheet(presented: $showChooseDistrict) {
                    VStack {
                        Group {
                           Button(action: {
                               self.showChooseDistrict = false
                           }, label: {
                               Text("完成")
                           }).offset(x: 150, y: -10)
                            
                            Text("Choose")
                            Picker(selection: self.$selectedIndex, label: Text("")) {
                                ForEach(0..<self.districts.count) { (index) in
                                    Button(action: {
                                        self.currentDistrict = String(self.districts[index])
                                    }) {Text(self.districts[index]) }
                                }
                            }
                        }
                        .frame(height: 50)
                        
                    }
                    .offset(x:-20 , y:0)
                }
                 List(shops.indices, id: \.self) { (index)  in
                     ShopRow(shop: self.shops[index])
                 }
                 .onAppear {
                     self.fetchShops()
                 }
                Spacer()
            }
            //.navigationBarTitle("台北市咖啡廳一覽表")
            .navigationBarItems(leading:
                HStack{
                    VStack{
                        Text("價格考量")
                            .bold()
                            .foregroundColor(Color.blue)
                            .contextMenu {
                                Button(action: {
                                    self.currentPrice = "昂貴"
                                }) {Text("昂貴")}
                                Button(action: {
                                    self.currentPrice = "中等"
                                }) {Text("中等")}
                                Button(action: {
                                    self.currentPrice = "便宜"
                                }) {Text("便宜")}
                                Button(action: {
                                    self.currentPrice = "不重要"
                                }) {Text("不重要")}
                        }
                        Text(currentPrice)
                    }
                    .offset(x: 0, y: 8)
                    
                },trailing:
                HStack{
                    Button(action: {
                        self.showChooseWifi = true
                    }) {Text("WIFI").bold()}
                        .actionSheet(isPresented: $showChooseWifi, content: {sheet})
                    Text(currentWifi)
                }
            )
        }
    }
}

struct ShopList_Previews: PreviewProvider {
    static var previews: some View {
        ShopList()
    }
}
