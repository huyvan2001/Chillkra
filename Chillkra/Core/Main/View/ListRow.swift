//
//  ListRow.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI

struct ListRow: View {
    let customSize = CustomSize()
    @State var pause: Bool = false
    var body: some View {
        ZStack(alignment: .topLeading){
            Image("Main.Brahaman")
                .scaledToFit()
                .frame(width: customSize.listRowWidth, height: customSize.listRowHeight)
            HStack{
                Spacer()
                Circle()
                    .frame(width: customSize.circleSize, height: customSize.circleSize)
                    .foregroundColor(Color("General.mainTextColor"))
                    .overlay(
                        Button(action: {
                            pause.toggle()
                        }, label: {
                            Image(systemName:pause == true ? "pause.fill": "play.fill")
                                .foregroundColor(Color("Main.IconColor"))
                        })
                    )
            }
            .padding()
            VStack(alignment: .leading){
                HStack{
                    VStack(alignment: .leading){
                        Text("20 Meditations\ntechnics")
                            .modifier(Fonts(fontName: FontsName.boldKalam, size: customSize.buttonText))
                            .padding(.bottom)
                        Text("Brahman")
                            .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.smallText))

                        Text("90 min")
                            .modifier(Fonts(fontName: FontsName.kalam, size: customSize.tinyText))
                            .padding(.top,3)
                    }
                    .foregroundColor(Color("General.mainTextColor"))
                    Spacer()
                }
                Spacer()
            }
            .padding()

        }
        .frame(width: customSize.listRowWidth, height: customSize.listRowHeight)
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow()
    }
}
