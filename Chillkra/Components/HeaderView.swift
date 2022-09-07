//
//  HeaderView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 05/09/2022.
//

import SwiftUI

struct HeaderView: View {
    let imageApp: String
    let textApp: String
    let name: String
    let personImage: String
    let title: String
    var customSize = CustomSize()
    
    var body: some View {
        VStack {
            HStack{
                Image(imageApp)
                    .resizable()
                    .frame(width: customSize.icontitleSize, height:customSize.icontitleSize)
                Text(textApp)
                    .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.mediumText))
                Spacer()
                
                if name != "" {
                    HStack{
                        Text(name)
                            .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
                        
                        NavigationLink {
                            SettingView()
                        } label: {
                            Image(personImage)
                                .resizable()
                                .frame(width: customSize.icontitleSize, height:customSize.icontitleSize)
                        }



                    }
                }
            }
            .padding(.top,32)
            .padding(.bottom)
            
            if title != "" {
                Text(title)
                    .padding(.top)
                    .modifier(Fonts(fontName: FontsName.boldKalam, size: customSize.largeText))
            }
        }
        .padding(.bottom)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(imageApp: "General.sun", textApp: "Chillkra", name: "Siddhi", personImage: "Person",title: "Search")
    }
}
