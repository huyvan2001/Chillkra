//
//  SearchView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var mainViewModel: MainViewModel
    
    @ObservedObject var download = SongDownload()
    @StateObject var songStore = SongStore()
    
    @Binding var selectedIndex: Int
    @State var textSearch: String = ""
    @State var isVisible = false
    var customSize = CustomSize()
    
    var body: some View {
        
        ZStack{
            if isVisible == false {
                VStack{
                    HeaderView(selectedIndex: $selectedIndex,
                               title: "Search")
                    
                    SearchBar(text: $textSearch)
                        .onTapGesture {
                            self.isVisible.toggle()
                        }
                    
                    historySearch
                        .padding(.bottom)
                    
                    
                    
                    recently
                    
                    
                    
                    
                    Spacer()
                }
            }
            else {
                withAnimation(.easeInOut(duration: 1)){
                    SearchSongView(selectedIndex: $selectedIndex,isVisible: $isVisible)
                        .padding(.top)
                }
            }
        }
        .navigationBarHidden(true)
        .foregroundColor(Color("General.mainTextColor"))
        .padding()
        .background(Color("backgroundColor"))
    }
    
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView(selectedIndex: .constant(1))
//            .environmentObject(AuthViewModel())
//    }
//}
extension SearchView {
    
    
    
    var historySearch: some View {
        VStack(alignment: .leading){
            Text("You might like...")
                .modifier(Fonts(fontName: FontsName.JosefinBold,
                                size: customSize.mediumText))
            
                .padding(.bottom)
            
            LazyVGrid(columns:[
                .init(.adaptive(minimum:customSize.rowSearchWidth),spacing: 30)
            ]){
                SearchRow(imageName: "Search.Yoga", name: "Yoga sessions", colorName: "Search.lightBlue")
                SearchRow(imageName: "Search.Space", name: "Space sounds", colorName: "Search.blue")
                SearchRow(imageName: "Search.Secrect", name: "Secret ingredients", colorName: "Search.lightPurple")
                SearchRow(imageName: "Search.Selfconfident", name: "Self confident", colorName: "Search.lightBlue")
                SearchRow(imageName: "Search.Horizonts", name: "Horizonts", colorName: "Search.blue")
                SearchRow(imageName: "Search.Sama", name: "Samsara", colorName: "Search.lightPurple")
            }
            
        }
    }
    
    
    
    var recently: some View {
        VStack(alignment: .leading){
            Text("Recently played")
                .modifier(Fonts(fontName: FontsName.JosefinBold,
                                size: customSize.mediumText))
                .padding(.bottom)
                .zIndex(0)
            GeometryReader{ mainView in
                ScrollView(.horizontal,showsIndicators: false){
                    LazyHStack{
                        ForEach(Array(zip(songStore.songs,
                                          songStore.songs.indices)),id: \.1){ song,index in
                            GeometryReader { item in
                                
                                Button {
                                    mainViewModel.songs = songStore.songs
                                    mainViewModel.song = song
                                    mainViewModel.playAtIndex(index: index)
                                             
                                } label: {
                                    MusicRow(song: song)
                                        .scaleEffect(customSize.scaleValue(mainFrame: mainView.frame(in: .global).minX,
                                                                minY: item.frame(in: .global).minX))
                                        .opacity(customSize.scaleValue(mainFrame: mainView.frame(in: .global).minX,
                                                            minY: item.frame(in: .global).minX))
                                }

                            }
                            .frame(width: customSize.MusicRowWidth)
                        }
                    }
                }
                .zIndex(1)
            }
        }
        .frame(height: 220)
        
    }
    
    
    
    
    
}
