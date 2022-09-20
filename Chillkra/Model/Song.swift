//
//  Music.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 09/09/2022.
//


import Foundation

struct Song: Codable,Identifiable,Equatable {
    let id = UUID()
    let nameSong: String
    let urlSong: String
    let imageSongUrl: String
    let singer, emotionType, lyric: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case id, nameSong, urlSong
        case imageSongUrl
        case singer, emotionType, lyric, type
    }
}

typealias Songs = [Song]
