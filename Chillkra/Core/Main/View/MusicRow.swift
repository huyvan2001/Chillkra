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
                    .frame(width: customSize.MusicRowWidth, height: customSize.MusicRowHeight)
                    .cornerRadius(customSize.radiusMusicRow)
                    .overlay(
                        VStack(){
                            HStack{
                                Spacer()
                                Text("")
                                    .modifier(Fonts(fontName: FontsName.kalam, size: customSize.tinyText))
                            }
                            .padding(10)
                            Spacer()
                        }
                    )
                
            }
            Text(song.nameSong)
                .padding(.bottom,3)
            Text(song.singer)
        }
        .modifier(Fonts(fontName: FontsName.kalam, size: customSize.tinyText))
        .foregroundColor(Color("General.mainTextColor"))
        }
    }

//struct MusicRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MusicRow(song: .init(nameSong: "", singer: "", type: "", emotionType: "", lyric: "", urlSong: "", imageSongUrl: ""))
//    }
//}
