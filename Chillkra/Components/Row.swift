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
                .frame(width: 100, height: 100)
            VStack(alignment: .leading){
                Text(song.nameSong)
                    .modifier(Fonts(fontName: .boldKalam, size: customSize.mediumText))
                Text(song.singer)
                    .modifier(Fonts(fontName: .kalam, size: customSize.smallText))
                Spacer()
            }
            .foregroundColor(Color("General.mainTextColor"))
            .padding()
            Spacer()
        }
    }
    
}

//struct Row_Previews: PreviewProvider {
//    static var previews: some View {
//        Row()
//    }
//}
