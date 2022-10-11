//
//  MainViewModel.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 13/09/2022.
//

import SwiftUI
import Foundation
import AVKit
import UserNotifications
class MainViewModel: ObservableObject{
    @ObservedObject var songStore = SongStore()
    @ObservedObject var download = SongDownload()
    @Published var player: AVAudioPlayer?
    @Published var width: CGFloat = 0
    @Published var currentSong = 0
    @Published var currentTime: TimeInterval = 0
    @Published var song = Song(id: UUID(), nameSong: "", urlSong: "", imageSongUrl: "", singer: "", emotionType: "", lyric: "", type: "", like: true, downloaded: true)
    @Published var angel: CGFloat = 0
    @Published var songs : [Song] = []
    @Published var searchText = ""
    @Published var locationUrl: URL?
    @Published var playing: Bool = true
    @Published var timer = Timer.publish(every: 0.1, on: .current, in: .default).autoconnect()
    @Published var isRepeat = false
    @Published var urlIsDownloading: URL?
    @Published var isRandom = false
    
    let fileManager = FileManager.default
    
    //MARK: SEARCHABLE SONG
    var SearchableSong: [Song] {
        if searchText == "" {
            return SongStore().songs
        }
        else {
            return SongStore().songs.filter({
                $0.nameSong.contains(searchText) ||
                $0.singer.contains(searchText)
            })
        }
    }
    //MARK: LIKE SONG
    func likeSong(song: Song){
        if let index = songStore.songs.firstIndex(of: song){
            songStore.songs[index].like = true
            self.song.like = true
        }
        
    }
    
    //MARK: UNLIKE SONG
    func unlikeSong(song: Song){
        if let index = songStore.songs.firstIndex(of: song){
            songStore.songs[index].like = false
            self.song.like = false
        }
    }
    
    
    //MARK: PLAY
    func played(){
        if playing == true {
            if player != nil{
                player!.play()
                return
            }
            do {
                guard let _locationUrl = self.locationUrl, self.fileExisted(in: _locationUrl) else {
                    return
                }
                player = try AVAudioPlayer(contentsOf: _locationUrl)
                player?.play()
            } catch {
                print(error)
            }
        }
    }
    
    private func fileExisted(in destinationUrl: URL) -> Bool {
        if fileManager.fileExists(atPath: destinationUrl.path){
            self.locationUrl = destinationUrl
            print(self.locationUrl!)
            return true
        }
        else{
            song.downloaded = true
            return false
        }
    }
    
    //MARK: PLAY AT INDEX
    func playAtIndex(index: Int){
        locationUrl = nil
        currentSong = index
        downloadButtonTapped(urlSong: song.urlSong)
    }
    
    
    //MARK: PLAYSONG
    func playsong(){
        if locationUrl != nil {
            played()
        }
        else {
            self.played()
        }
    }
    
    
    //MARK: UPDATE TIME SONG
    func updateTimer(){
        
        guard let player = self.player else { return }
        if player.isPlaying{
            let screen = UIScreen.main.bounds.width - 30
            currentTime = player.currentTime
            let total = player.duration
            let progess = currentTime / total
            self.width = screen*CGFloat(progess)
        }
        
        }
    
    
    //MARK: NEXT SONG
    func nextSong(songs: [Song]){
        locationUrl = nil
        self.currentSong = currentSong + 1
        if currentSong == songs.count {
            currentSong = 0
        }
        song = songs[currentSong]
        downloadButtonTapped(urlSong: songs[currentSong].urlSong)
        playsong()
    }
    
    
    //MARK: REPEAT SONG
    func repeatSong(){
        if Int(self.currentTime) == Int(player!.duration){
            locationUrl = nil
            song = songs[currentSong]

            downloadButtonTapped(urlSong: songs[currentSong].urlSong)
            playsong()
        }
    }
    
    //MARK: AUTO RANDOM SONG
    func autoRandomSong(){
        if player != nil {
            if Int(self.currentTime) == Int(player!.duration){
                randomSong()
            }
        }
    }
    
    //MARK: RANDOM SONG
    func randomSong(){
        locationUrl = nil
        let currentSongrandom = Int.random(in: 0..<songs.count)
        self.currentSong = currentSongrandom
        song = songs[currentSong]
        downloadButtonTapped(urlSong: songs[currentSong].urlSong)
        playsong()
    }
    
    
    //MARK: BACK SONG
    func backSong(songs: [Song]){
        locationUrl = nil
        self.currentSong = currentSong - 1
        if currentSong == -1 {
            currentSong = songs.count - 1
        }
        song = songs[currentSong]
        downloadButtonTapped(urlSong: songs[currentSong].urlSong)
        playsong()
        
        
    }
    
    //MARK: AUTO NEXT SONG
    func autoNextSong() {
        if player != nil{
            if Int(self.currentTime) == Int(player!.duration) {
                nextSong(songs: songs)
            }
        }
    }
    
    //MARK: PAUSE
    func paused(){
        player?.pause()
    }
    
    //MARK: STOP
    func stopped(){
        player?.stop()
        player = nil
    }
    
    //MARK: GET CURRENT TIME
    func getCurrentTime(value: TimeInterval)-> String{
        
        if player != nil {
            return "\(Int(value/60)):\(Int(value.truncatingRemainder(dividingBy: 60)) <= 9 ? "0": "")\(Int(value.truncatingRemainder(dividingBy: 60)))"
        }
        return "00:00"
    }
    
    
   //MARK: DOWNLOAD SONG
    func downloadButtonTapped(urlSong: String){
        guard let previewUrl = URL(string:urlSong) else { return}
        if previewUrl == urlIsDownloading { return }
        self.download.fetchSongUrl(previewUrl) { downloaded in
            if downloaded {
                DispatchQueue.main.async {
                    self.locationUrl = self.download.locationUrl!
                    self.playsong()
                }
            } else {
                print("ERROR")
            }
        }
    }
    
    //MARK: CREATE NOTIFICATION
    func createNotification(){
        
        let content = UNMutableNotificationContent()
        
        content.title = "Chillkra"
        content.subtitle = "Come back to listen music"
        
        let triggle = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "IN-APP", content: content, trigger: triggle)
        UNUserNotificationCenter.current().add(request)
    }
    
    
    
}
