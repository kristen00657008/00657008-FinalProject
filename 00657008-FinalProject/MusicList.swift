//
//  ContentView.swift
//  MusicApp
//
//  Created by SHIH-YING PAN on 2019/11/27.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import SwiftUI

struct MusicList: View {
    
    @State private var songs = [Song]()
    @State private var currentSinger: String = ""
    @State private var showAlert = false
    @State private var showSingerAlert = false
    @State private var showInputAlert = false
    
    func fetchSongs(_singer: String ) {
          print(_singer)
          let urlStr = "https://itunes.apple.com/search?term=\(_singer)"
          if let url = URL(string: urlStr) {
              URLSession.shared.dataTask(with: url) { (data, response , error) in
                  let decoder = JSONDecoder()
                  if let data = data, let songResults = try? decoder.decode(SongResults.self, from: data) {
                    self.songs = songResults.results
                    
                  }
              }.resume()
              
          }
      }
        
    var body: some View {
        //彼得潘
        NavigationView {
            
            List(songs.indices, id: \.self) { (index)  in
                NavigationLink(destination: SongDetail(song: self.songs[index])) {
                    SongRow(song: self.songs[index])

                }
            }
            .navigationBarTitle("歌曲列表")
            .navigationBarItems(leading:
                HStack{
                    EditButton()
                        .padding(5)
                }
                ,trailing:
                HStack{
                    Button(action: {
                        if self.currentSinger == "" {
                            self.showAlert = true
                        }
                        self.fetchSongs(_singer: self.currentSinger)
                        if self.songs.count == 0 && self.currentSinger != ""{
                            sleep(1)
                            if self.songs.count == 0{
                                self.showAlert = true
                                self.showInputAlert = true
                            }
                        }
                        print(self.showSingerAlert)
                    }) {
                        Text("新增")
                    }
                    .alert(isPresented: self.$showAlert) { () -> Alert in
                        if self.showInputAlert == true {
                            return Alert(title:Text("找不到此歌手的音樂"),message: Text("請重新輸入"))
                        }
                        else if self.showSingerAlert == true {
                            return Alert(title: Text("請先輸入歌手名稱"))
                        }
                        else{
                            return Alert(title: Text("找不到此歌手的音樂"),message: Text("請重新輸入"))
                        }
                     
                    }
                    /*.alert(isPresented: self.$showSingerAlert) { () -> Alert in
                        return Alert(title: Text("找不到此歌手的音樂喔 請重新輸入")
                        )
                    }*/
                    
                    Button(action: {
                        let alertHC = UIHostingController(rootView: MyAlert(currentSinger: self.$currentSinger).frame(width: 350, height: 200))

                        alertHC.preferredContentSize = CGSize(width: 100, height: 100)
                        alertHC.modalPresentationStyle = UIModalPresentationStyle.formSheet
                        UIApplication.shared.windows[0].rootViewController?.present(alertHC, animated: true)
                        
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            )
            .onAppear {
                self.fetchSongs(_singer: self.currentSinger)
            }
        }
    }
}

struct MyAlert: View {
    @Binding var currentSinger: String
    
    var body: some View {

        VStack {
            Text("想聽誰的歌？").font(.headline).padding()

            TextField("ex:彼得潘",text: $currentSinger).padding()
            Divider()
            HStack {
                Spacer()
                Button(action: {
                    UIApplication.shared.windows[0].rootViewController?.dismiss(animated: true,completion:{})
                }) {
                    Text("完成")
                }
                Spacer()

                Divider()

                Spacer()
                Button(action: {
                    UIApplication.shared.windows[0].rootViewController?.dismiss(animated: true, completion: {})
                }) {
                    Text("取消")
                }
                Spacer()
            }.padding(0)


            }.background(Color(white: 0.9))
    }
}

struct MusicList_Previews: PreviewProvider {
    static var previews: some View {
        MusicList()
    }
}

