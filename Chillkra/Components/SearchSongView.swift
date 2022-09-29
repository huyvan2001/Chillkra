//
//  SearchView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 26/09/2022.
//

import SwiftUI
import Kingfisher
struct SearchSongView: View {
    @ObservedObject var download = SongDownload()
    var customSize = CustomSize()
    @ObservedObject var songStore = SongStore()
    @Environment(\.presentationMode) var presentationMode
    @Binding var locationUrl: URL?
    @Binding var selectedIndex: Int
    @State var checkUrlLocation:Bool?
    @Binding var song: Song
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
                TextField("Artists, songs, or podcasts",text: $songStore.searchText)
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
                    .frame(width: customSize.searchBarWidth, height: customSize.searchBarHeight)
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
                        ForEach(songStore.SearchableSong) { song in
                            GeometryReader{ item in
                                Button {
                                    self.locationUrl = nil
                                    self.song = song
                                    downloadButtonTapped()
                                    if checkUrlLocation == true {
                                        DispatchQueue.main.async {
                                            self.locationUrl = download.locationUrl
                                            self.selectedIndex = 4
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                        
                                    }
                                    else {
                                        DispatchQueue.main.asyncAfter(deadline: .now()+15){
                                            self.locationUrl = download.locationUrl
                                            self.selectedIndex = 4
                                            presentationMode.wrappedValue.dismiss()
                                        }
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
    func downloadButtonTapped(){
        guard let previewUrl = URL(string: song.urlSong) else {return}
        self.download.fetchSongUrl(previewUrl) { check in
            self.checkUrlLocation = check
        }
    }
    
    
    
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchSongView(song: song)
//    }
//}

