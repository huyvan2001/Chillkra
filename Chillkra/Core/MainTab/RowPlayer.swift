//
//  RowPlayer.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI
import Kingfisher
import AVKit

struct RowPlayer: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    
    @ObservedObject var download = SongDownload()
    @ObservedObject var songStore = SongStore()
    
    
    @Binding var  locationUrl: URL?
    @Binding var song: Song
    @State var checkUrlLocation:Bool?
    @State var pause: Bool = true
    @State var favs: Bool = true
    @Binding var currentSong:Int
    @State var width: CGFloat = 0
    @State var value: Double = 0
    
    var customSize = CustomSize()
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                HStack{
                    
                    KFImage(URL(string: song.imageSongUrl))
                        .resizable()
                        .frame(width: 49, height: 50)
                    VStack(alignment: .leading){
                        MarqueeText(text: song.nameSong, font: UIFont.preferredFont(forTextStyle:.title2), leftFade: 1, rightFade: 1, startDelay: 0.5)
                            .foregroundColor(Color("Main.NameSong"))
                            .frame(width: 100)
                        Text(song.singer)
                            .foregroundColor(Color("backgroundColor"))
                            .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
                    }
                }
                .padding()
                
                Spacer()
                
                HStack{
                    
                    Button {
                        favs.toggle()
                    } label: {
                        Image(systemName: "heart.fill")
                            .font(.title3)
                            .foregroundColor(Color(favs == true ? "backgroundColor": "Main.IconPlay"))
                    }
                    
                    Button {
                        pause.toggle()
                        if pause == false {
                            mainViewModel.paused()
                        }
                        else {
                            mainViewModel.played(locationUrl: locationUrl)
                        }
                    } label: {
                        Image(systemName: pause == true ? "pause.fill" : "play.fill")
                            .foregroundColor(Color("Main.IconPlay"))
                            .font(.largeTitle)
                    }
                    
                    Button {
                        currentSong = currentSong + 1
                        if self.currentSong == songStore.songs.count {
                            self.currentSong = 0
                        }
                        self.song = songStore.songs[currentSong]
                        downloadButtonTapped()
                        if checkUrlLocation == true {
                            DispatchQueue.main.async {
                                self.locationUrl = download.locationUrl
                            }
                            
                        }
                        else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 15){
                                self.locationUrl = download.locationUrl
                            }
                        }
                        mainViewModel.stopped()
                        play()
                    } label: {
                        Image(systemName: "forward.end.fill")
                            .foregroundColor(Color("Main.IconPlay"))
                            .font(.title3)
                    }
                    
                    
                    
                }
                .padding()
            }
            .frame(height: customSize.rowPlayerHeight)
            .background(LinearGradient(colors: [Color("Main.ColorRowPlayerStart").opacity(0.9),Color("Main.ColorRowPlayerEnd").opacity(0.9)], startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(customSize.radiusMusicRow)
            .onAppear(){
               play()
                
                guard let player = mainViewModel.player else { return }
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                    if player.isPlaying {
                        let screen = UIScreen.main.bounds.width - 30
                        let value = player.currentTime / player.duration
                        self.width = screen * CGFloat(value)
                    }
                }
            }
            .onChange(of: song) { _ in
                width = 0
                mainViewModel.stopped()
                play()
                
                self.pause = true
                guard let player = mainViewModel.player else { return }
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                    if player.isPlaying {
                        let screen = UIScreen.main.bounds.width - 30
                        value = player.currentTime / player.duration
                        self.width = screen * CGFloat(value)
                    }
                }
            }
            ZStack(alignment: .leading){
                Capsule().fill(Color.black.opacity(0.08)).frame(height:3)
                Capsule().fill(Color.red).frame(width: width,height: 3)
            }
            .offset(y:-8)
        }
        

    }

    func play(){
        if locationUrl != nil {
            mainViewModel.played(locationUrl: locationUrl)
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now()+15){
                mainViewModel.played(locationUrl: locationUrl)
            }
        }
    }
    
    
    func downloadButtonTapped(){
        guard let previewUrl = URL(string: song.urlSong) else {return}
        self.download.fetchSongUrl(previewUrl) { check in
            self.checkUrlLocation = check
        }
    }
}

//struct RowPlayer_Previews: PreviewProvider {
//    static var previews: some View {
//        RowPlayer(song: .init(nameSong: "", singer: "", type: "", emotionType: "", lyric: "", urlSong: "", imageSongUrl: ""))
//    }
//}
