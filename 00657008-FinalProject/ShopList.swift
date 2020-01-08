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
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var shops = [Shop]()
    @State private var currentShops = [Shop]()
    @State private var tempShops = [Shop]()
    @State private var currentWifi = ""
    @State private var currentDistrict = "所有地區"
    @State private var tempDistrict = ""
    @State private var currentPrice = ""
    @State private var showChooseDistrict = false
    @State private var showChooseWifi = false
    @State private var showChoosePrice = false
    var urlStr: String  
    var districts: [String]
    
    func fetchShops(_currentShops: [Shop]) {
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                if let data = data, let shop = try? decoder.decode([Shop].self, from: data) {
                    self.shops = shop
                    print(_currentShops.count)
                    if _currentShops.count == 0{
                        self.currentShops = self.shops
                    }
                }
            }.resume()
        }
    }
    func judgeDistrict() {
        if(self.currentDistrict == "所有地區"){
            self.currentShops = self.shops
        }
        else {
            self.tempShops.removeAll()
            
            print(self.currentDistrict)
            for shop in self.shops {
                let address = shop.address
                var temp: [String]
                var zone: String
                temp = address.components(separatedBy: "區")
                zone = String(temp[0].suffix(2)) + "區"
                if (zone == self.currentDistrict){
                    self.tempShops.append(shop)
                }
            }
            self.currentShops = self.tempShops
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
        GeometryReader{ (geometry) in
            NavigationView{
                VStack {
                    List(self.currentShops.indices, id: \.self) { (index)  in
                        NavigationLink(destination: ShopDetail(shop: self.currentShops[index])) {
                            ShopRow(shop: self.currentShops[index])
                                .frame(height:geometry.size.height * 35 / 414)
                        }
                    }
                    .frame(height:geometry.size.height * 400 / 414)
                    .onAppear {
                        self.fetchShops(_currentShops: self.currentShops)
                        UITableView.appearance().separatorColor = .clear
                    }
                    Spacer()
                }
                .navigationBarItems(leading:
                    HStack{
                        Button(action: {
                            self.showChooseDistrict = true
                        }){Text(self.currentDistrict).bold().font(Font.system(size: 20))}
                    },trailing:
                    VStack{
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width:geometry.size.width * 22 / 414,height: geometry.size.height * 12 / 414)
                        }
                    }
                )
            }
            .partialSheet(presented: self.$showChooseDistrict) {
                VStack {
                    Group {
                        Button(action: {
                            self.showChooseDistrict = false
                            self.currentDistrict = self.tempDistrict
                            self.judgeDistrict()
                        }, label: {
                            Text("完成")
                        }).offset(x: geometry.size.width * 150 / 414, y: geometry.size.height * 10 / 414)
                        
                        Text("請選擇區域")
                            .offset(x:geometry.size.width * 0 / 414,y:geometry.size.height * -20 / 414)
                        Picker(selection: self.$tempDistrict, label: Text("")) {
                            ForEach(0..<self.districts.count) { (index) in
                                Text(self.districts[index]).tag(self.districts[index]).foregroundColor(Color.blue)
                            }
                        }
                        .offset(x: geometry.size.width * -50 / 414, y: geometry.size.height * -30 / 414)
                    }
                    .frame(height: geometry.size.height * 40 / 414)
                }
            }
            
        }
    }
}

struct ShopList_Previews: PreviewProvider {
    static var previews: some View {
        ShopList(urlStr: "",districts: [""])
    }
}
