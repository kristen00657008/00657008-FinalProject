//
//  ChooseDistrict.swift
//  00657008-FinalProject
//
//  Created by User16 on 2019/12/15.
//  Copyright © 2019 00657008. All rights reserved.
//

import SwiftUI

struct ChooseDistrict: View {
    @Binding var selectedIndex:Int
    var districts = ["中正區","大同區","中山區","松山區","大安區","萬華區","信義區","士林區","北投區","內湖區","南港區","文山區"]
    
    var body: some View {
        
        Section{
            Picker(selection: self.$selectedIndex, label: Text("")){
                ForEach(0..<self.districts.count) { (index) in
                    Text(self.districts[index])
                }
            }
        }
    }
}

struct ChooseDistrict_Previews: PreviewProvider {
    static var previews: some View {
        ChooseDistrict(selectedIndex: .constant(0))
    }
}
