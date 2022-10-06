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
    
    @StateObject var songStore = SongStore()
    
    @State var currentTime: TimeInterval = 0
    @Binding var selectedIndex: Int
    
    let customSize = CustomSize()
    
    var body: some View {
        VStack(){
            HeaderView(selectedIndex: $selectedIndex, title: "")
            
            KFImage(URL(string: mainViewModel.song.imageSongUrl))
                .resizable()
                .frame(width: 200,height: 200)
                .padding()

            name
                .padding(20)
            
            
            HStack{
                
                Text(mainViewModel.getCurrentTime(value: mainViewModel.player!.currentTime))
                    .padding()
                Slider(value: $mainViewModel.currentTime , in: 0...(mainViewModel.player!.duration))
                { isEditing in
                    if !isEditing {
                        
                        mainViewModel.player?.currentTime = mainViewModel.currentTime
                        mainViewModel.played()
                        mainViewModel.timer = Timer.publish(every: 0.1, on: .current, in: .default).autoconnect()
                        
                    }
                    else{
                        mainViewModel.timer.upstream.connect().cancel()
                    }
                }
                .frame(height: 4)
                Text(mainViewModel.getCurrentTime(value: mainViewModel.player!.duration))
                    .padding()
            }
              
            play
            
            
            action
            
            Spacer()
        }
        .navigationBarHidden(true)
        .foregroundColor(Color("General.mainTextColor"))
        .padding()
        .onAppear(){
            mainViewModel.playsong()
        }
        .onChange(of: mainViewModel.song){ _ in
            
            mainViewModel.stopped()
            
            mainViewModel.playsong()
            mainViewModel.playing = true
            
        }
        .onReceive(mainViewModel.timer, perform: { (_) in
            
            mainViewModel.autoNextSong()
            mainViewModel.updateTimer()
            
        })

        .ignoresSafeArea()
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
            Text(mainViewModel.song.nameSong)
                .modifier(Fonts(fontName: FontsName.kalam,
                                size: customSize.mediumText))
                .padding()
            Text(mainViewModel.song.singer)
                .modifier(Fonts(fontName: FontsName.JosefinBold,
                                size: customSize.tinyText))
        }
    }
    
    
    var play: some View {
        HStack{
            Button {
                mainViewModel.backSong(songs: mainViewModel.songs)
            } label: {
                Image(systemName: "backward.end.fill")
                    .modifier(Fonts(fontName: FontsName.kalam,
                                    size: customSize.mediumText))
                    .padding()
            }
            
            Button {
                mainViewModel.playing.toggle()
                if mainViewModel.playing == true {
                    mainViewModel.played()
                }
                else {
                    mainViewModel.paused()
                }
            } label: {
                Image(systemName: mainViewModel.playing == true ? "pause.circle.fill" : "play.circle.fill")
                    .modifier(Fonts(fontName: FontsName.kalam,
                                    size: customSize.bigText))
                    .padding()
            }
            
            Button {
                mainViewModel.nextSong(songs: mainViewModel.songs)
            } label: {
                Image(systemName: "forward.end.fill")
                    .modifier(Fonts(fontName: FontsName.kalam,
                                    size: customSize.mediumText))
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
        .modifier(Fonts(fontName: FontsName.kalam,
                        size: customSize.mediumText))
    }
}
