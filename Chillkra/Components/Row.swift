//
//  Row.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 26/09/2022.
//

import SwiftUI
import Kingfisher
struct Row: View{
    var song: Song
    var customSize = CustomSize()
    var body: some View {
        HStack(alignment: .top){
            KFImage(URL(string: song.imageSongUrl))
                .resizable()
                .frame(width: 100,
                       height: 100)
            VStack(alignment: .leading){
                Text(song.nameSong)
                    .modifier(Fonts(fontName: .boldKalam,
                                    size: customSize.mediumText))
                Text(song.singer)
                    .modifier(Fonts(fontName: .kalam,
                                    size: customSize.smallText))
                HStack{
                    Spacer()
                        Image(systemName: "heart.fill")
                            .modifier(Fonts(fontName: .kalam,
                                            size: customSize.smalltinyText))
                            .foregroundColor(Color(song.like == false ?  "Main.IconPlay": "heartColor"))
                    
                }
                Spacer()
            }
            .foregroundColor(Color("General.mainTextColor"))
            .padding()
            Spacer()
        }
        .background(Color("Search.blue").shadow(color:Color.black.opacity(0.12),radius: 5,x:0,y:4))
        .cornerRadius(15)
    }
    
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Row(song: Song(id: UUID(),
                       nameSong: "Em dau biet",
                       urlSong: "",
                       imageSongUrl: "",
                       singer: "Le Van Huy",
                       emotionType: "",
                       lyric: "",
                       type: "", like: true))
    }
}
