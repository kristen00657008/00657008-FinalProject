//
//  Song.swift
//  00657008-FinalProject
//
//  Created by User16 on 2020/1/7.
//  Copyright © 2020 00657008. All rights reserved.
//

import Foundation

//
//  Song.swift
//  MusicApp
//
//  Created by SHIH-YING PAN on 2019/11/27.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import Foundation

struct Song: Codable {
    var artistName: String
    var trackName: String
    var previewUrl: URL
    var artworkUrl100: URL
    var trackPrice: Double?
    var collectionName: String?

}

struct SongResults: Codable {
    var resultCount: Int
    var results: [Song]
}
