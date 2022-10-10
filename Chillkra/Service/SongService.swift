//
//  SongService.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 09/09/2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct SongService {
    var download = SongDownload()
    let documentpath = FileManager.documentsDirectoryURL
    
    let stringUrlSong = "https://firebasestorage.googleapis.com/v0/b/chillkra-dc0e4.appspot.com/o/JSON%2Fsongs.json?alt=media&token=e23f9be7-dfae-4e49-99e5-83cfa698eb15"
    let stringUrlType = "https://firebasestorage.googleapis.com/v0/b/chillkra-dc0e4.appspot.com/o/JSON%2Ftypes.json?alt=media&token=49fb1eca-f05c-4d54-b367-0e07aadbda8c"
    let stringUrlEType = "https://firebasestorage.googleapis.com/v0/b/chillkra-dc0e4.appspot.com/o/JSON%2FemotionTypes.json?alt=media&token=dd37b3a0-47cc-41d8-9eb2-429ead3e1397"
    
    
    
    func fetchJSONSong(){
        guard let url = URL(string: stringUrlSong) else {return }
        let lastpathcomponent = url.lastPathComponent
        let destinationUrl = documentpath.appendingPathComponent(lastpathcomponent)

        let task = URLSession.shared.downloadTask(with: url){ location,response,error in
            
            do {
                try FileManager.default.copyItem(at: location!, to: destinationUrl)
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    func fetchJSONType(){
        guard let url = URL(string: stringUrlType) else {return }
        let lastpathcomponent = url.lastPathComponent
        let destinationUrl = documentpath.appendingPathComponent(lastpathcomponent)
        if FileManager.default.fileExists(atPath: destinationUrl.path){
            return
        }
        let task = URLSession.shared.downloadTask(with: url){ location,response,error in
            do{
                try FileManager.default.copyItem(at: location!, to: destinationUrl)
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    func fetchJSONEtype(){
        guard let url = URL(string: stringUrlEType) else {return }
        let lastpathcomponent = url.lastPathComponent
        let destinationUrl = documentpath.appendingPathComponent(lastpathcomponent)
        if FileManager.default.fileExists(atPath: destinationUrl.path){
            return
        }
        let task = URLSession.shared.downloadTask(with: url){ location,response,error in
            do{
                try FileManager.default.copyItem(at: location!, to: destinationUrl)
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func fetchSong(withUid uid: String , completion: @escaping(Song)-> Void){
        Firestore.firestore().collection("songs")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                guard let song = try? snapshot.data(as: Song.self) else { return }
                completion(song)
            }
        
    }
    func fetchSongs(completion:@escaping([Song])-> Void){
        Firestore.firestore().collection("songs")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let songs = documents.compactMap({try? $0.data(as: Song.self)})
                completion(songs)
            }
    }
}
