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
    init(){
    }
    
    func played(locationUrl: URL?){
        if player != nil{
            player!.play()
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: locationUrl!)
            player?.play()
        } catch {
            print(error)
        }
        
    }
    func paused(){
        player?.pause()
    }
    func stopped(){
        player?.stop()
        player = nil
    }
    
}
