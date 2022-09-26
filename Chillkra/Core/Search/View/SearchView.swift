//
//  SearchView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var download = SongDownload()
    @Binding var song: Song
    @Binding var locationUrl: URL?
    @Binding var selectedIndex: Int
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var mainViewModel: MainViewModel
    @State var textSearch: String = ""
    @StateObject var songStore = SongStore()
    var customSize = CustomSize()
    @State var checkUrlLocation:Bool?
    var body: some View {
        VStack{
            HeaderView(selectedIndex: $selectedIndex, title: "Search")
            
            
            NavigationLink(destination: SearchSongView(locationUrl: $locationUrl, selectedIndex: $selectedIndex, song: $song)) {
                SearchBar(text: $textSearch)
            }
            
            
            
            historySearch
                .padding(.bottom)
            
            
            
            recently
            
            
            
            
            Spacer()
        }
        .navigationBarHidden(true)
        .foregroundColor(Color("General.mainTextColor"))
        .padding()
        .background(Color("backgroundColor"))
    }
    
    func downloadButtonTapped(){
        guard let previewUrl = URL(string: song.urlSong) else {return}
        self.download.fetchSongUrl(previewUrl) { check in
            self.checkUrlLocation = check
        }
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
                .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.mediumText))
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
                .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.mediumText))
                .padding(.bottom)
            ScrollView(.horizontal,showsIndicators: false){
                LazyHStack{
                    ForEach(songStore.songs){ song in
                        Button {
                            self.locationUrl = nil
                            self.song = song
                            downloadButtonTapped()
                            if checkUrlLocation == true {
                                DispatchQueue.main.async {
                                    self.locationUrl = download.locationUrl
                                }
                                
                            }
                            else {
                                DispatchQueue.main.asyncAfter(deadline: .now()+15){
                                    self.locationUrl = download.locationUrl
                                }
                            }
                            
                        } label: {
                            MusicRow(song: song)
                        }

                    }
                }
            }
        }
        .frame(height: 220)
        
    }
    
    
    
    
    
}
