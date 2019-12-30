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
    @State private var newShops = [Shop]()
    @State private var currentWifi = ""
    @State private var currentDistrict = "所有地區"
    @State private var tempDistrict = ""
    @State private var currentPrice = ""
    @State private var showChooseDistrict = false
    @State private var showChooseWifi = false
    @State private var showChoosePrice = false
    var urlStr: String  
    var districts: [String]
        
    func fetchShops() {
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                if let data = data, let shop = try? decoder.decode([Shop].self, from: data) {
                    self.shops = shop
                }
            }.resume()
        }
    }
    
    func ifDistrict(_index: Int) -> Bool {
        if(self.currentDistrict == "所有地區"){
            return true
        }
        else {
            let address = shops[_index].address
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
                 
                 List(shops.indices, id: \.self) { (index)  in
                    if(self.ifDistrict(_index: index)){
                        NavigationLink(destination: ShopDetail(shop: self.shops[index])) {
                            ShopRow(shop: self.shops[index],currentDistrict: self.currentDistrict)
                                .frame(height:35)
                        }                        
                    }
                    else {
                        ShopRow(shop: self.shops[index],currentDistrict: self.currentDistrict)
                            .frame(height:0)
                    }
                    
                 }
                 .frame(height:700)
                 .onAppear {
                     self.fetchShops()
                 }
                Spacer()
            }
            .navigationBarItems(leading:
                HStack{
                    VStack{
                        Text("價格考量")
                            .bold()
                            .font(Font.system(size: 20))
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
                    .offset(x: 20, y: 18)
                    VStack{
                        Button(action: {
                            self.showChooseDistrict = true
                        }){Text(currentDistrict).bold().font(Font.system(size: 20))}
                            .offset(x:20,y:11)
                    }
                    .offset(x: 40, y: 0)
                    
                },trailing:
                VStack{
                    Button(action: {
                       self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width:22,height:22)
                    }
                    .offset(x: 28,y:15)
                    
                    Button(action: {
                        self.showChooseWifi = true
                    }) {Text("WIFI").bold().font(Font.system(size: 25))}
                        .offset(x: -40,y:0)
                        .actionSheet(isPresented: $showChooseWifi, content: {sheet})
                    Text(currentWifi)
                    
                }
                .offset(x: 0,y: 3)
            )
        }
        .partialSheet(presented: $showChooseDistrict) {
            VStack {
                Group {
                   Button(action: {
                        self.showChooseDistrict = false
                        self.currentDistrict = self.tempDistrict
                   /* ForEach(shops.self) { (index) in
                        
                    }*/
                   }, label: {
                       Text("完成")
                   }).offset(x: 150, y: -10)
                    
                    Text("請選擇區域")
                        .offset(x:0,y:-20)
                    Picker(selection: self.$tempDistrict, label: Text("")) {
                        ForEach(0..<self.districts.count) { (index) in
                            Text(self.districts[index]).tag(self.districts[index])
                        }
                    }
                    .offset(x:-50,y:0)
                }
                .frame(height: 40)
            }
        }
    }
}

struct ShopList_Previews: PreviewProvider {
    static var previews: some View {
        ShopList(urlStr: "",districts: [""])
    }
}
