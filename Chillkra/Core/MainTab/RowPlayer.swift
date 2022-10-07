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
    
    @ObservedObject var songStore = SongStore()
    
    @State var checksongfinished = false
    var customSize = CustomSize()
    
    var body: some View {

        VStack{
            
            HStack{
                
                HStack{
                    
                    KFImage(URL(string: mainViewModel.song.imageSongUrl))
                        .resizable()
                        .frame(width: 49, height: 50)
                    
                    VStack(alignment: .leading){
                        
                        MarqueeText(text: mainViewModel.song.nameSong,
                                    font: UIFont.preferredFont(forTextStyle:.title2),
                                    leftFade: 1,
                                    rightFade: 1,
                                    startDelay: 0.5)
                            .foregroundColor(Color("Main.NameSong"))
                            .frame(width: 100)
                        Text(mainViewModel.song.singer)
                            .foregroundColor(Color("backgroundColor"))
                            .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
                    }
                }
                .padding()
                
                Spacer()
                
                HStack{
                    
                    Button {
                        mainViewModel.song.like == true ? mainViewModel.unlikeSong(song: mainViewModel.song) : mainViewModel.likeSong(song: mainViewModel.song)
                    } label: {
                        Image(systemName: "heart.fill")
                            .font(.title3)
                            .foregroundColor(Color(mainViewModel.song.like == false ?  "Main.IconPlay": "heartColor"))
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
                        Image(systemName: mainViewModel.playing == true ? "pause.fill" : "play.fill")
                            .foregroundColor(Color("Main.IconPlay"))
                            .font(.largeTitle)
                    }
                    
                    Button {
                        if mainViewModel.isRandom == true {
                            mainViewModel.randomSong()
                        }
                        else {
                            mainViewModel.nextSong(songs: mainViewModel.songs)
                        }
                    } label: {
                        Image(systemName: "forward.end.fill")
                            .foregroundColor(Color("Main.IconPlay"))
                            .font(.title3)
                    }
                    
                    
                    
                }
                .padding()
            }
            .frame(height: customSize.rowPlayerHeight)
            .background(LinearGradient(colors: [Color("Main.ColorRowPlayerStart").opacity(0.9),
                                                Color("Main.ColorRowPlayerEnd").opacity(0.9)],
                                       startPoint: .leading,
                                       endPoint: .trailing)
            )
            .cornerRadius(customSize.radiusMusicRow)
            
            .onAppear(){
                
                mainViewModel.playsong()
            }
            .onChange(of: mainViewModel.song.id) { _ in
                
                mainViewModel.width = 0
                mainViewModel.stopped()
                mainViewModel.playsong()
                
                mainViewModel.playing = true
            }
            .onReceive(mainViewModel.timer, perform: { (_) in
                
                if mainViewModel.isRepeat == true {
                    mainViewModel.repeatSong()
                }
                else if mainViewModel.isRandom == true {
                    if mainViewModel.isRepeat == true {
                        mainViewModel.repeatSong()
                    }
                    else {
                        mainViewModel.autoRandomSong()
                    }
                }
                else{
                    mainViewModel.autoNextSong()
                    
                }
                mainViewModel.updateTimer()
                
            })

           
            
            ZStack(alignment: .leading){
                Capsule().fill(Color.black.opacity(0.08)).frame(height:3)
                Capsule().fill(Color.red).frame(width: mainViewModel.width,height: 3)
            }
            .padding(.leading)
            .offset(y:-8)
        }
        

    }

    
}

//struct RowPlayer_Previews: PreviewProvider {
//    static var previews: some View {
//        RowPlayer(song: .init(nameSong: "", singer: "", type: "", emotionType: "", lyric: "", urlSong: "", imageSongUrl: ""))
//    }
//}
