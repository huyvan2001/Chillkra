//
//  AddSongViewModel.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 21/09/2022.
//

import Foundation
import SwiftUI
class AddSongViewModel: ObservableObject{
    func saveImageSong(_ image: UIImage,compeltion: @escaping(String) -> Void){
        ImageUploader.uploadSongImage(image: image) { url in
            print(url)
            compeltion(url)
        }
    }
}
