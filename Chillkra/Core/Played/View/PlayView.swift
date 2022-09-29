//
//  PlayView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 07/09/2022.
//

import SwiftUI
import AVFoundation
import Kingfisher

struct PlayView: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    @EnvironmentObject var viewModel: AuthViewModel
    
    @ObservedObject var download = SongDownload()
    @ObservedObject var songStore = SongStore()

    @Binding var currentSong:Int
    @State var pause: Bool = false
    @State var checkUrlLocation:Bool?
    @State var value: Double = 0
    @State var width: CGFloat = 0
    @Binding var  locationUrl: URL?
    @Binding var song: Song
    @Binding var selectedIndex: Int
    
    let customSize = CustomSize()
    
    var body: some View {
            VStack(){
                HeaderView(selectedIndex: $selectedIndex, title: "")
                
                
                KFImage(URL(string: song.imageSongUrl))
                    .resizable()
                    .frame(width: 200,height: 200)
                    .padding()
                
                name
                    .padding(20)
               
                
                ZStack(alignment: .leading){
                    Capsule().fill(Color.black.opacity(0.08)).frame(height:8)
                    Capsule().fill(Color.red).frame(width: width,height: 8)
                }
                
                
                play
                
                
                action
                
                Spacer()
            }
            .navigationBarHidden(true)
            .foregroundColor(Color("General.mainTextColor"))
            .padding()
            .onAppear(){
                playsong()
                
                
                guard let player = mainViewModel.player else { return }
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                    if player.isPlaying {
                        let screen = UIScreen.main.bounds.width - 30
                        let value = player.currentTime / player.duration
                        self.width = screen * CGFloat(value)
                    }
                }
            }
            .onChange(of: song){ _ in
                
                width = 0
                mainViewModel.stopped()
                playsong()
                self.pause = false
                
                
                guard let player = mainViewModel.player else { return }
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                    if player.isPlaying {
                        let screen = UIScreen.main.bounds.width - 30
                        value = player.currentTime / player.duration
                        self.width = screen * CGFloat(value)
                    }
                }
            }
            .ignoresSafeArea()
    }
    
    
    func playsong(){
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

//struct PlayView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayView(selectedIndex: .constant(2))
//            .environmentObject(AuthViewModel())
//    }
//}

extension PlayView {
    var name: some View {
        VStack{
            Text(song.nameSong)
                .modifier(Fonts(fontName: FontsName.kalam, size: customSize.largeText))
                .padding()
            Text(song.singer)
                .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.mediumText))
        }
    }
    
    
    var play: some View {
        HStack{
            Button {
                currentSong = currentSong - 1
                if self.currentSong == -1 {
                    self.currentSong = songStore.songs.count-1
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
                playsong()
            } label: {
                Image(systemName: "backward.end.fill")
                    .modifier(Fonts(fontName: FontsName.kalam, size: customSize.mediumText))
                    .padding()
            }

            Button {
                pause.toggle()
                if pause == true {
                    mainViewModel.paused()
                }
                else {
                    mainViewModel.played(locationUrl: locationUrl)
                }
            } label: {
                Image(systemName: pause == true ? "play.circle.fill" : "pause.circle.fill")
                    .modifier(Fonts(fontName: FontsName.kalam, size: customSize.bigText))
                    .padding()
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
                playsong()
            } label: {
                Image(systemName: "forward.end.fill")
                    .modifier(Fonts(fontName: FontsName.kalam, size: customSize.mediumText))
                    .padding()
            }

        }
        .padding()
    }
    
    
    var action: some View {
        HStack{
            Image(systemName: "repeat")
                .padding()
            Image(systemName: "shuffle")
                .padding()
            Image(systemName: "moon.fill")
                .padding()
            Image(systemName: "heart")
                .padding()
        }
        .padding()
        .modifier(Fonts(fontName: FontsName.kalam, size: customSize.mediumText))
    }
}
