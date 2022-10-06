//
//  SearchView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 26/09/2022.
//

import SwiftUI
import Kingfisher

struct SearchSongView: View {

    @EnvironmentObject var mainViewModel: MainViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var songStore = SongStore()
    
    @Binding var selectedIndex: Int
    
    var customSize = CustomSize()
    
    var body: some View {
        VStack(alignment: .leading){
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.backward.circle")
                    .font(.largeTitle)
                    .foregroundColor(Color("General.mainTextColor"))
            }

            HStack{
                TextField("Artists, songs, or podcasts",
                          text: $mainViewModel.searchText)
                    .padding(.horizontal,34)
                    .padding()
                    .overlay(
                        HStack{
                            Image(systemName: "magnifyingglass")
                            Spacer()
                            
                        }
                            .padding()
                    )
                    .foregroundColor(Color("Search.ColorSearch"))
                    .frame(width: customSize.searchBarWidth,
                           height: customSize.searchBarHeight)
                    .background(Color.white)
                    .cornerRadius(10)
                Spacer()
            }
            .padding()
            .zIndex(0)
            //moving view in stack for shadow effect
            
            GeometryReader { mainView in
                
                ScrollView(.vertical,showsIndicators: false){
                    
                    LazyVStack{
                        ForEach(Array(zip(mainViewModel.SearchableSong,
                                          mainViewModel.SearchableSong.indices)),id:\.1) { song,index in
                            GeometryReader{ item in
                                
                                Button {
                                    
                                    mainViewModel.songs = mainViewModel.SearchableSong
                                    mainViewModel.song = song
                                    mainViewModel.playing = true
                                    mainViewModel.playAtIndex(index: index)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                        self.selectedIndex = 4
                                    }
                                    
                                    
                                } label: {
                                    
                                    Row(song: song)
                                        .padding(.bottom)
                                        .padding(.leading)
                                        .scaleEffect(customSize.scaleValue(mainFrame: mainView.frame(in: .global).minY,
                                                                minY: item.frame(in: .global).minY),anchor: .bottom)
                                        .opacity(customSize.scaleValue(mainFrame: mainView.frame(in: .global).minY,
                                                            minY: item.frame(in: .global).minY))
                                }
                            }
                            // setting default frame height
                            .frame(height: 100)

                        }
                    }
                }
                .zIndex(1)
            }
            
        }
        .navigationBarHidden(true)
        .padding()
        .background(Color("backgroundColor"))
        
    }

    
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchSongView(song: song)
//    }
//}

