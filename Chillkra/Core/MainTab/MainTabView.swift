//
//  MainTabView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//
import SwiftUI

struct MainTabView: View {
    @State var song : Song = .init(nameSong: "", singer: "", type: "", emotionType: "", lyric: "", urlSong: "", imageSongUrl: "")
    @State var locationUrl: URL?
    let customSize = CustomSize()
    @State private var selectedIndex = 0
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var mainViewModel: MainViewModel
    var body: some View {
        VStack{
            if selectedIndex == 0 {
                MainView(locationUrl: $locationUrl, song: $song, selectedIndex: $selectedIndex)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
            
            
            
            else if selectedIndex == 1 {
                SearchView(song: $song, locationUrl: $locationUrl, selectedIndex: $selectedIndex)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)            }
            
            
            
            else if selectedIndex == 2 {
                StatsView(selectedIndex: $selectedIndex)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)            }
            
            
            
            else if selectedIndex == 3 {
                FavsView(selectedIndex: $selectedIndex)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
            
            
            
            else if selectedIndex == 4{
                PlayView(song:$song,selectedIndex: $selectedIndex)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
            
            
            else if selectedIndex == 5 {
                ScrollView(.vertical){
                    VStack{
                        SettingView(selectedIndex: $selectedIndex)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
            
            
            
            Spacer()
        }
        .background(Color("backgroundColor"))
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .overlay(
            VStack{
                Spacer()
                if song.nameSong != "" {
                    if selectedIndex != 4{
                        Button {
                            self.selectedIndex = 4
                        } label: {
                            RowPlayer(locationUrl: $locationUrl, song:song)
                                .padding(.bottom,-8)
                        }
                    }
                }
                TabBar(selectedIndex: $selectedIndex)
                
            }
        )
        .ignoresSafeArea()
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(AuthViewModel())
    }
}
