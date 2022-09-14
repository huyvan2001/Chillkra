//
//  Music.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 09/09/2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Song: Identifiable,Decodable,Equatable{
    @DocumentID var id: String?
    let nameSong: String
    let singer: String
    let type: String
    let emotionType:String
    let lyric: String
    let urlSong: String
    let imageSongUrl: String
    
}


