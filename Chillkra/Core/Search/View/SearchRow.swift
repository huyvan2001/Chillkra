//
//  SearchRow.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI

struct SearchRow: View {
    let imageName: String
    let name: String
    let colorName: String
    var customSize = CustomSize()
    var body: some View {
        VStack{
            
        }
        .frame(width: customSize.rowSearchWidth, height: customSize.rowSearchHeight)
        .background(Color(colorName))
        .overlay(
            HStack{
                Image(imageName)
                Spacer()
                Text(name)
                    .modifier(Fonts(fontName: FontsName.kalam, size: customSize.tinyText))
                    .foregroundColor(.white)
                Spacer()
            }
        )
        .cornerRadius(customSize.radiusSearch)
    }
}

struct SearchRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchRow(imageName: "", name: "", colorName: "")
    }
}
