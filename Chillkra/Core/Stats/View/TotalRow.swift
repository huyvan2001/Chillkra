//
//  TotalRow.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 07/09/2022.
//

import SwiftUI

struct TotalRow: View {
    let title: String
    let amount: String
    let nameAmount: String
    let timeupdate: String
    let customSize = CustomSize()
    var body: some View {
        VStack{
            Text(title)
                .modifier(Fonts(fontName: FontsName.kalam,
                                size: customSize.largetinyText))
            Text(amount)
                .modifier(Fonts(fontName: FontsName.kalam,
                                size: customSize.bigText))
            Text(nameAmount)
                .modifier(Fonts(fontName: FontsName.kalam, size: customSize.tinyText))
                .foregroundColor(Color("Setting.ColorTitle"))
            Text(timeupdate)
                .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smalltinyText))
                .foregroundColor(Color("Main.ColorRowPlayerStart"))
                .padding(3)
        }
        .frame(width: customSize.totalRowWidth, height: customSize.totalRowHeight)
        .background(Color("Stats.Colorrow").opacity(0.15))
        .cornerRadius(customSize.totalRadius)
        .padding()
    }
}

struct TotalRow_Previews: PreviewProvider {
    static var previews: some View {
        TotalRow(title: "Total played", amount: "120K", nameAmount: "reproductions", timeupdate: "Last update yesterday")
    }
}
