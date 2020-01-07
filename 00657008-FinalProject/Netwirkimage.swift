//
//  NetworkImage.swift
//  MusicApp
//
//  Created by SHIH-YING PAN on 2019/11/27.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import SwiftUI

struct NetworkImage: View {
    var url: URL
    @State private var downloadImage: UIImage?
    var body: some View {
        Group {
            if downloadImage != nil {
                Image(uiImage: downloadImage!)
                    .resizable()
            } else {
                Image(systemName: "photo")
                    .resizable()
            }
        }
        .onAppear {
            self.downLoad()
        }
    }
    func downLoad() {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let uiImage = UIImage(data: data) {
                self.downloadImage = uiImage
            }
        }.resume()
    }
}


struct NetworkImage_Previews: PreviewProvider {
    static var previews: some View {
        NetworkImage(url: URL(string: "https://cdn2.thecatapi.com/images/6ph.jpg")!)
    }
}

