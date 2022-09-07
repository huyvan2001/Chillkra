//
//  ListFeelRow.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI

struct FeelRow: View {
    let imageName: String
    let RowName: String
    let customSize = CustomSize()
    var body: some View {
        VStack{
            Image(imageName)
                .scaledToFit()
                .frame(width: customSize.iconFeelSize, height: customSize.iconFeelSize)
                .cornerRadius(customSize.iconFeelRadius)
            Text(RowName)
        }
        .modifier(Fonts(fontName: FontsName.kalam, size: customSize.tinyText))
        .foregroundColor(Color("General.mainTextColor"))
    }
}

struct FeelRow_Previews: PreviewProvider {
    static var previews: some View {
        FeelRow(imageName: "", RowName: "")
    }
}
