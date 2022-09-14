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
    @Binding var  locationUrl: URL?
    @EnvironmentObject var mainViewModel: MainViewModel
    let song: Song
    var customSize = CustomSize()
    @State var pause: Bool = true
    @State var favs: Bool = true
    
    
    var body: some View {
        VStack{
            HStack{
                HStack{
                    KFImage(URL(string: song.imageSongUrl))
                        .resizable()
                        .frame(width: 49, height: 50)
                    VStack(alignment: .leading){
                        Text(song.nameSong)
                            .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.mediumText))
                            .foregroundColor(Color("Main.NameSong"))
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
                        //
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 10){
                    mainViewModel.played(locationUrl: locationUrl)
                }
            }
            .onChange(of: song) { _ in
                mainViewModel.paused()
                DispatchQueue.main.asyncAfter(deadline: .now() + 10){
                    mainViewModel.played(locationUrl: locationUrl)
                }
            }
            
        }

    }
}

//struct RowPlayer_Previews: PreviewProvider {
//    static var previews: some View {
//        RowPlayer(song: .init(nameSong: "", singer: "", type: "", emotionType: "", lyric: "", urlSong: "", imageSongUrl: ""))
//    }
//}
