//
//  ListMusicRow.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI

struct MusicRow: View {
    let imageName: String
    let time: String
    let NameRow: String
    let NameSinger: String
    let customSize = CustomSize()
    var body: some View {
        VStack{
            VStack{
                Image(imageName)
                    .scaledToFit()
                    .frame(width: customSize.MusicRowWidth, height: customSize.MusicRowHeight)
                    .cornerRadius(customSize.radiusMusicRow)
                    .overlay(
                        VStack(){
                            HStack{
                                Spacer()
                                Text(time)
                                    .modifier(Fonts(fontName: FontsName.kalam, size: customSize.tinyText))
                            }
                            .padding(10)
                            Spacer()
                        }
                    )
                    
            }
            Text(NameRow)
                .padding(.bottom,3)
            Text(NameSinger)
        }
        .modifier(Fonts(fontName: FontsName.kalam, size: customSize.tinyText))
        .foregroundColor(Color("General.mainTextColor"))
    }
}

struct MusicRow_Previews: PreviewProvider {
    static var previews: some View {
        MusicRow(imageName: "Main.LostMountain", time: "15m", NameRow: "Lost Mountain", NameSinger: "Shiva")
    }
}
