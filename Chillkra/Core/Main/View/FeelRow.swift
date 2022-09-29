//
//  ListFeelRow.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI
import Kingfisher
struct FeelRow: View {
    let urlImageName: String
    let RowName: String
    let customSize = CustomSize()
    
    var body: some View {
        
        VStack{
            KFImage(URL(string: urlImageName))
                .resizable()
                .frame(width: customSize.iconFeelSize, height: customSize.iconFeelSize)
                .cornerRadius(customSize.iconFeelRadius)
            
            Text(RowName)
        }
        .modifier(Fonts(fontName: FontsName.kalam, size: customSize.tinyText))
        .foregroundColor(Color("General.mainTextColor"))
    }
}

//struct FeelRow_Previews: PreviewProvider {
//    static var previews: some View {
//        FeelRow(imageName: "", RowName: "")
//    }
//}
