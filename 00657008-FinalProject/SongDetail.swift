//
//  SongDetail.swift
//  MusicApp
//
//  Created by SHIH-YING PAN on 2019/12/4.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import SwiftUI
import AVKit

struct SongDetail: View {
    var song: Song
    @State private var player: AVPlayer?
    var body: some View {
        GeometryReader { (geometry) in
            VStack {
                NetworkImage(url: self.song.artworkUrl100)
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                Text(self.song.trackName)
                    .font(Font.system(size: 30))
                Text(self.song.artistName)
                Button(action: {
                    self.player = AVPlayer(url: self.song.previewUrl)
                    self.player?.play()
                }) {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
            }
            .onDisappear {
                self.player?.pause()
            }
            .frame(width: geometry.size.width, height: 900)
            .background(Color.init(red: 182/255, green: 171/255, blue: 171/255))
        }
        
    }
}

struct SongDetail_Previews: PreviewProvider {
    static var previews: some View {
        SongDetail(song: Song(artistName: "", trackName: "love song", previewUrl: URL(string: "https://cdn2.thecatapi.com/images/6ph.jpg")!, artworkUrl100: URL(string: "https://cdn2.thecatapi.com/images/6ph.jpg")!, trackPrice: 1, collectionName: "aa"))
    }
}

