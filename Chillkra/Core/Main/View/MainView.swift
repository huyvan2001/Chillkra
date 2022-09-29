//
//  MainView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var mainViewModel: MainViewModel
    
    @ObservedObject var songStore = SongStore()
    @ObservedObject var download = SongDownload()
    
    
    @Binding var locationUrl: URL?
    @Binding var song: Song
    @Binding var selectedIndex: Int
    @Binding var currentSong: Int
    @State var checkUrlLocation:Bool?
    
    var customSize = CustomSize()
    
    var body: some View {
        VStack(alignment: .leading){
            
            HeaderView(selectedIndex: $selectedIndex, title: "")
                .zIndex(0)
            
                
            GeometryReader{
                mainView in
                ScrollView(showsIndicators: false){
                    GeometryReader{ item in
                        recently
                            .scaleEffect(customSize.scaleValue(mainFrame: mainView.frame(in: .global).minY,
                                                    minY: item.frame(in: .global).minY),anchor: .bottom)
                            .opacity(customSize.scaleValue(mainFrame: mainView.frame(in: .global).minY,
                                                minY: item.frame(in: .global).minY))
                    }
                    .frame(height: 220)
                    GeometryReader{ item in
                        feelRow
                            .scaleEffect(customSize.scaleValue(mainFrame: mainView.frame(in: .global).minY,
                                                    minY: item.frame(in: .global).minY),anchor: .bottom)
                            .opacity(customSize.scaleValue(mainFrame: mainView.frame(in: .global).minY,
                                                minY: item.frame(in: .global).minY))
                    }
                    .frame(height: 180)
                    
                    VStack{
                            ForEach(1...10,id:\.self){ _ in
                                GeometryReader{ item in
                                    ListRow()
                                        .scaleEffect(customSize.scaleValue(mainFrame: mainView.frame(in: .global).minY,
                                                                           minY: item.frame(in: .global).minY),anchor: .bottom)
                                        .opacity(customSize.scaleValue(mainFrame: mainView.frame(in: .global).minY,
                                                                       minY: item.frame(in: .global).minY))
                                }
                                .frame(width:customSize.listRowWidth,height: customSize.listRowHeight)
                            }
                        }
                }
                .zIndex(1)
            }
            
            
            
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

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(locationUrl: .constant(URL(string: "")), song: .constant(try! Song(from: Song.init(nameSong: "", urlSong: "", imageSongUrl: "", singer: "", emotionType: "", lyric: "", type: "") as! Decoder)), selectedIndex: .constant(5))
//    }
//}
extension MainView{
    
    var recently: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Recently")
                    .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.mediumText))
                Spacer()
                NavigationLink {
                    AddSongView()
                } label: {
                    HStack{
                        Image(systemName: "plus.circle")
                            .font(.largeTitle)
                    }
                }
                
            }
            .zIndex(0)
            
            GeometryReader{ mainView in
                ScrollView(.horizontal,showsIndicators: false){
                    LazyHStack{
                        ForEach(Array(zip(songStore.songs.indices,songStore.songs)),id: \.1){ index,song in
                            GeometryReader{ item in
                                Button {
                                    self.locationUrl = nil
                                    self.song = song
                                    self.currentSong = index
                                    downloadButtonTapped()
                                    if checkUrlLocation == true {
                                        DispatchQueue.main.async {
                                            self.locationUrl = download.locationUrl
                                        }
                                        
                                    }
                                    else {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 15){
                                            self.locationUrl = download.locationUrl
                                        }
                                    }
                                    
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
    
    var feelRow: some View {
        VStack(alignment: .leading){
            Text("How do you feel today?")
                .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.mediumText))
            HStack{
                ForEach(songStore.eTypes,id:\.idEType){ etype in
                    Spacer()
                    NavigationLink(destination: ListFeelSongView(locationUrl: $locationUrl, selectedIndex: $selectedIndex,song:$song,eType: etype)) {
                        FeelRow(urlImageName: etype.UrlImageEType, RowName: etype.nameEType)
                    }
                    Spacer()
                }
            }
        }
    }
}
