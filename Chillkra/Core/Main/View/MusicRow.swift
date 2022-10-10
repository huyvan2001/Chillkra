//
//  ListMusicRow.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI
import Kingfisher
struct MusicRow: View {
    
    var song: Song
    let customSize = CustomSize()
    
    
    var body: some View {
        
        VStack{
            
            VStack{
                
                KFImage(URL(string: song.imageSongUrl))
                    .resizable()
                    .frame(width: customSize.MusicRowWidth,
                           height: customSize.MusicRowHeight)
                    .cornerRadius(customSize.radiusMusicRow)
                    .overlay(
                        VStack(){
                            HStack{
                                Spacer()
                                Image(systemName: song.downloaded == true ? "" : "arrow.down.app.fill")
                                    .padding(8)
                            }
                            Spacer()
                        }
                    )
                
            }
            
            Text(song.nameSong)
                .padding(.bottom,3)
            
            Text(song.singer)
            
        }
        .modifier(Fonts(fontName: FontsName.kalam,
                        size: customSize.tinyText))
        .foregroundColor(Color("General.mainTextColor"))
        }
    }

struct MusicRow_Previews: PreviewProvider {
    static var previews: some View {
        MusicRow(song: Song(id: UUID(), nameSong: "Anh chua thuong ", urlSong: "", imageSongUrl: "", singer: "", emotionType: "", lyric: "", type: "", like: true, downloaded: true))
    }
}
