//
//  FavsRowView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI

struct FavsRow: View {
    
    let imageName: String
    let nameSong: String
    let nameSinger: String
    let customSize = CustomSize()
    
    var body: some View {
        
        Image(imageName)
            .resizable()
            .frame(width: customSize.favsRowSize,
                   height: customSize.favsRowSize)
            .cornerRadius(customSize.favsRowRadius)
            .overlay(
                VStack{
                    Spacer()
                    Text(nameSong)
                        .modifier(Fonts(fontName: FontsName.boldKalam,
                                        size: customSize.tinyText))
                    Text(nameSinger)
                        .modifier(Fonts(fontName: FontsName.Josefin,
                                        size: customSize.tinyText))
                }
                    .foregroundColor(Color("General.mainTextColor"))
                    .padding()
            )
            .padding()
    }
}

struct FavsRow_Previews: PreviewProvider {
    static var previews: some View {
        FavsRow(imageName: "", nameSong: "", nameSinger: "")
    }
}
