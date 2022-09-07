//
//  MainTabView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI

struct MainTabView: View {
    let customSize = CustomSize()
    @State private var selectedIndex = 0
    var body: some View {
        ZStack(alignment: .bottom){
            if selectedIndex == 0 {
                MainView()
            }
            else if selectedIndex == 1 {
                SearchView()
        
            }
            else if selectedIndex == 2 {
                StatsView()
            }
            else if selectedIndex == 3 {
                FavsView()
            }
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
            .frame(width:.infinity,height: customSize.TabHeight)
            .background(Color("Tab.ColorTab"))
            .cornerRadius(customSize.TabRadius)
            .shadow(color: .white.opacity(0.6), radius: customSize.radiusButton)
            RowPlayer().offset(x:0, y:-87.5)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
