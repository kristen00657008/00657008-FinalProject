//
//  ShopList.swift
//  00657008-FinalProject
//
//  Created by User16 on 2019/12/15.
//  Copyright © 2019 00657008. All rights reserved.
//

import SwiftUI

struct ShopList: View {
    
    @State private var shops = [Shop]()
    @State private var selectedIndex = 0
    @State private var currentDistrict = "選擇區域"
    @State private var showChooseDistrict = false
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
    var body: some View {
        
        NavigationView{
            List(shops.indices, id: \.self) { (index)  in
                ShopRow(shop: self.shops[index])
            }
            .onAppear {
                self.fetchShops()
            }
            //.navigationBarTitle("台北市咖啡廳一覽表")
            .navigationBarItems(leading:
                HStack{
                    Button(action: {
                        self.showChooseDistrict = true
                    }) {
                        Text("選擇區域")
                    }
                    .sheet(isPresented: $showChooseDistrict) {
                        Picker(selection: self.$selectedIndex, label: Text("")){
                            ForEach(0..<self.districts.count) { (index) in
                               Text(self.districts[index])
                            }
                        }
                    }
                    
                    
                    
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
