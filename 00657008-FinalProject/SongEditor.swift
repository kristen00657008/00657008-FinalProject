//
//  SongEditor.swift
//  LoveSong
//
//  Created by User24 on 2019/11/18.
//  Copyright © 2019 User24. All rights reserved.
//
import SwiftUI

struct SongEditor: View {
    @Environment(\.presentationMode) var presentationMode
    var songsData: SongsData
    @State private var name = ""
    @State private var singer = ""
    
    var editSong : Song?
    var body: some View {
        Form{
            TextField("歌曲名稱", text: $name)
            TextField("歌手", text: $singer)
            
        }
        .navigationBarTitle(editSong == nil ? "新增歌曲" : "編輯歌曲")
        .navigationBarItems(trailing: Button("儲存") {
            let song = Song(name: self.name, singer: self.singer)
                if let editSong = self.editSong{
                    let index = self.songsData.songs.firstIndex {
                        return $0.id == editSong.id
                    }!
                    self.songsData.songs[index] = song
                } else {
                    self.songsData.songs.insert(song, at: 0)
                }
                self.presentationMode.wrappedValue.dismiss()
        })
        .onAppear{
            if let editSong = self.editSong{
                self.name = editSong.name
                self.singer = editSong.singer
            }
        }
    }
}

struct SongEditor_Previews: PreviewProvider {
    static var previews: some View {
        SongEditor(songsData: SongsData())
    }
}
