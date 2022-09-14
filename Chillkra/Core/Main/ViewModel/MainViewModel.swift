//
//  MainViewModel.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 13/09/2022.
//

import SwiftUI
import Foundation
import AVKit
class MainViewModel: ObservableObject{
    
    @Published var player: AVAudioPlayer?
    @Published var songs = [Song]()
    let songService = SongService()
    init(){
        self.fetchSong()
    }
    
    func fetchSong(){
        songService.fetchSongs { songs in
            self.songs = songs
        }
    }
    
    func played(locationUrl: URL?){
        do {
            player = try! AVAudioPlayer(contentsOf: locationUrl!)
            player?.play()
            
        }
    }
    func paused(){
        player?.pause()
    }
    
}
