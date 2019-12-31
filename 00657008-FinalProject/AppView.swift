//
//  AppView.swift
//  00657008-FinalProject
//
//  Created by User16 on 2019/12/31.
//  Copyright © 2019 00657008. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView{
            ChooseCity().tabItem{
                Image(systemName: "flag.fill")
                Text("咖啡廳")
            }
            MusicList().tabItem{
                Image(systemName: "music.house.fill")
                Text("歌曲列表")
            }
        }
        .accentColor(.purple)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
