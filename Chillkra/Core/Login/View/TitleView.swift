//
//  TitleView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 05/09/2022.
//

import SwiftUI

struct TitleView: View {
    let title: String
    let description1: String
    let description2: String
    let customSize = CustomSize()
    var body: some View {
        VStack(alignment:.leading){
            Text(title)
                .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.buttonText))
                .padding(.bottom,2)
            Text(description1)
                .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
            Text(description2)
                .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
        }
        .padding(.bottom)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "", description1: "", description2: "")
    }
}
