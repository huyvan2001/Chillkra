//
//  SongStore.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 20/09/2022.
//

import Foundation
//
//  SongStore.swift
//  TestJSON
//
//  Created by Lê Văn Huy on 16/09/2022.
//

import Foundation


class SongStore:ObservableObject{
    @Published var songs: [Song] = [] {
        didSet{
            saveJSONSong()
            print("OKKK")
        }
    }
    @Published var types: [Types] = []
    @Published var eTypes: [EType] = []
    init(){
        loadJSON()
    }
    
    func loadJSON(){
        do {
            guard let typesURL = Bundle.main.url(forResource: "types",withExtension: "json"),
                  let songsJSONURL = Bundle.main.url(forResource: "songs",withExtension: "json"),
                  let eTypesURL = Bundle.main.url(forResource: "emotionTypes",withExtension: "json")
            else {
                return }
            let songData = try Data(contentsOf: songsJSONURL)
            let typeData = try Data(contentsOf: typesURL)
            let EtypeData = try Data(contentsOf: eTypesURL)
            songs = try JSONDecoder().decode([Song].self, from: songData)
            types = try JSONDecoder().decode([Types].self, from: typeData)
            eTypes = try JSONDecoder().decode([EType].self, from: EtypeData)
        }
        catch{
            print("xxxx \(error)")
        }
    }
    func saveJSONSong(){
        guard let songsJSONURL = Bundle.main.url(forResource: "songs",withExtension: "json") else { return }
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let songData = try encoder.encode(songs)
            try songData.write(to: songsJSONURL)
        }
        catch let error {
           print(error)
        }
    }
    func addSong(nameSong: String, urlSong: String, imageSongUrl: String, singer: String, emotionType: String,lyric: String,type: String){
        let song = Song(nameSong: nameSong, urlSong: urlSong, imageSongUrl: imageSongUrl, singer: singer, emotionType: emotionType, lyric: lyric, type: type)
        songs.append(song)
        objectWillChange.send()
        print(songs)
    }
}
