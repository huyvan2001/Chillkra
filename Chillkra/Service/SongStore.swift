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
    var songsJSONURL = URL(fileURLWithPath: "songs", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    var typesJSONURL = URL(fileURLWithPath: "types", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    var eTypesJSONURL = URL(fileURLWithPath: "emotionTypes", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    @Published var songs: [Song] = [] {
        didSet{
            saveJSONSong()
        }
    }
    @Published var types: [Types] = []
    @Published var eTypes: [EType] = []
    
    init(){
        loadJSON()
    }
    
    //MARK: LoadJSON
    func loadJSON(){
        do {
            let songData = try Data(contentsOf: songsJSONURL)
            let typeData = try Data(contentsOf: typesJSONURL)
            let EtypeData = try Data(contentsOf: eTypesJSONURL)
            songs = try JSONDecoder().decode([Song].self, from: songData)
            types = try JSONDecoder().decode([Types].self, from: typeData)
            eTypes = try JSONDecoder().decode([EType].self, from: EtypeData)
        }
        catch{
            print("xxxx \(error)")
        }
    }
    
    //MARK: SAVEJSON
    func saveJSONSong(){
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
    
    //MARK: ADDSONG
    func addSong(nameSong: String,
                 urlSong: String,
                 imageSongUrl: String,
                 singer: String,
                 emotionType: String,
                 lyric: String,
                 type: String,
                 callback:@escaping()->Void){
        let song = Song(id: UUID(),
                        nameSong: nameSong,
                        urlSong: urlSong,
                        imageSongUrl: imageSongUrl,
                        singer: singer,
                        emotionType: emotionType,
                        lyric: lyric,
                        type: type,
                        like: true,
                        downloaded: true)
        songs.append(song)
        callback()
        objectWillChange.send()
        print(songs)
    }
    
    //MARK: LISTFEELSONG
    func listFeelSong(idEtype: String)-> [Song]{
        return songs.filter({
            $0.emotionType.contains(idEtype)
        })
    }
    
    
}
