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
