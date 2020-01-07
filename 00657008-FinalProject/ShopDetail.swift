//
//  ShopDetail.swift
//  00657008-FinalProject
//
//  Created by User16 on 2019/12/30.
//  Copyright © 2019 00657008. All rights reserved.
//

import SwiftUI
import MapKit

struct HeightButton: View {
    var shop: Shop
    @Binding var annotations : [MKPointAnnotation]
    @Binding var mapHeight: CGFloat
    @Binding var smallMap: Bool
    var body: some View {
        HStack {
            if (smallMap == false){
                Button("縮小地圖") {
                    self.mapHeight = 200
                    self.smallMap = true
                }
            }
            else {
                Button("放大地圖") {
                    self.mapHeight = 600
                    self.smallMap = false
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: (self.shop.latitude as NSString).doubleValue , longitude: (self.shop.longitude as NSString).doubleValue)
                    annotation.title = "\(self.shop.name)"
                    self.annotations.append(annotation)
                }
            }
            /*Spacer()
            Button("新增標籤") {
                
            }*/
            
        }
        
    }
}

struct ShopDetail: View {
    var shop: Shop
    @State private var annotations = [MKPointAnnotation]()
    @State private var mapHeight: CGFloat = 200
    @State private var smallMap: Bool = true
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading){
                HeightButton(shop: self.shop,annotations: self.$annotations,mapHeight: self.$mapHeight.animation(),smallMap: self.$smallMap)
                MapView(coordinate: CLLocationCoordinate2D(latitude: (self.shop.latitude as NSString).doubleValue , longitude: (self.shop.longitude as NSString).doubleValue ),annotations: self.annotations).frame(height: self.mapHeight)
                /*if(self.smallMap) {
                    Group {
                        HStack{
                            Text("店名:").font(Font.system(size: 30))
                            Spacer()
                            Text(self.shop.name).padding(.trailing,0).font(Font.system(size: 30))
                        }.padding(.bottom,5)
                        HStack{
                            Text("地址:").font(Font.system(size: 30))
                            Spacer()
                            Text(self.shop.address).padding(.trailing,0).font(Font.system(size: 20))
                        }.padding(.bottom,5)
                        HStack{
                            Text("營業時間:").font(Font.system(size: 30))
                            Spacer()
                            Text(self.shop.open_time!).padding(.trailing,0).font(Font.system(size: 20))
                        }.padding(.bottom,5)
                        HStack{
                            Text("Wifi:").font(Font.system(size: 30))
                            Spacer()
                            Text(String(self.shop.wifi)).padding(.trailing,0).font(Font.system(size: 30))
                        }.padding(.bottom,5)
                        HStack{
                            Text("座位:").font(Font.system(size: 30))
                            Spacer()
                            Text(String(self.shop.seat)).padding(.trailing,0).font(Font.system(size: 30))
                        }.padding(.bottom,5)
                        HStack{
                            Text("安靜:").font(Font.system(size: 30))
                            Spacer()
                            Text(String(self.shop.quiet)).padding(.trailing,0).font(Font.system(size: 30))
                        }.padding(.bottom,5)
                        HStack{
                            Text("美味:").font(Font.system(size: 30))
                            Spacer()
                            Text(String(self.shop.tasty)).padding(.trailing,0).font(Font.system(size: 30))
                        }.padding(.bottom,5)
                        HStack{
                             Text("價錢:").font(Font.system(size: 30))
                             Spacer()
                             Text(String(self.shop.cheap)).padding(.trailing,0).font(Font.system(size: 30))
                         }.padding(.bottom,5)
                    }
                    Group {
                        HStack{
                            Text("插座:").font(Font.system(size: 30))
                            Spacer()
                            Text(self.shop.socket!).padding(.trailing,0).font(Font.system(size: 30))
                        }.padding(.bottom,5)
                        HStack{
                            Text("站立式座位:").font(Font.system(size: 30))
                            Spacer()
                            Text(self.shop.standing_desk!).padding(.trailing,0).font(Font.system(size: 30))
                        }.padding(.bottom,5)
                        HStack{
                            Text("時間限制:").font(Font.system(size: 30))
                            Spacer()
                            Text(self.shop.limited_time!).padding(.trailing,0).font(Font.system(size: 30))
                        }.padding(.bottom,5)
                    }
                }*/
                
            }            
        }.navigationBarTitle(self.shop.name)
        
        
    }
}

struct ShopDetail_Previews: PreviewProvider {
    static var previews: some View {
        ShopDetail(shop: Shop(  id: UUID(),
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
                                limited_time: ""  ))
    }
}
