//
//  MainTabView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//
import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var mainViewModel: MainViewModel
    
    @State var song : Song = .init(nameSong: "", urlSong: "", imageSongUrl: "", singer: "", emotionType: "", lyric: "", type: "")
    @State var locationUrl: URL?
    @State private var selectedIndex = 0
    @State var currentSong = 0
    
    let customSize = CustomSize()
    
    var body: some View {
        VStack{
            
            
            if selectedIndex == 0 {
                MainView(locationUrl: $locationUrl, song: $song, selectedIndex: $selectedIndex, currentSong: $currentSong)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
            
            
            else if selectedIndex == 1 {
                SearchView(song: $song, locationUrl: $locationUrl, selectedIndex: $selectedIndex)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)            }
            
            
            else if selectedIndex == 2 {
                StatsView(selectedIndex: $selectedIndex)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)            }
            
            
            
            else if selectedIndex == 3 {
                FavsView(selectedIndex: $selectedIndex, song: $song, locationUrl:$locationUrl)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
            
            
            
            else if selectedIndex == 4{
                PlayView(currentSong: $currentSong, locationUrl: $locationUrl, song:$song,selectedIndex: $selectedIndex)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
            
            
            else if selectedIndex == 5 {
                ScrollView(.vertical,showsIndicators: false){
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
                            RowPlayer(locationUrl: $locationUrl, song:$song, currentSong: $currentSong)
                                .padding(.bottom,-16)
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
