//
//  TabRowView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 07/09/2022.
//

import SwiftUI

struct TabBar: View {
    let customSize = CustomSize()
    @Binding var selectedIndex: Int
    var body: some View {
        HStack{
            Spacer()
            
            Button {
                selectedIndex = 0
            } label: {
                Image(selectedIndex == 0 ? "Tab.HomeFill" : "Tab.Home")
            }
            .padding()
            
            Spacer()
            
            Button {
                selectedIndex = 1
            } label: {
                Image(selectedIndex == 1 ? "Tab.SearchFill" : "Tab.Search")
            }
            .padding()
            
            Spacer()
            
            
            Button {
                selectedIndex = 2
            } label: {
                Image(selectedIndex == 2 ? "Tab.StatFill" : "Tab.Stat")
            }
            .padding()
            
            Spacer()
            
            
            Button {
                selectedIndex = 3
            } label: {
                Image(selectedIndex == 3 ? "Tab.FavsFill" : "Tab.Favs")
            }
            .padding()
            
            Spacer()
            
        }
        .frame(height: customSize.TabHeight)
        .background(Color("Tab.ColorTab"))
        .cornerRadius(customSize.TabRadius)
        .shadow(color: .white.opacity(0.6), radius: customSize.radiusButton)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selectedIndex: .constant(2))
    }
}
