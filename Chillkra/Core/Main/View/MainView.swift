//
//  MainView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var download = SongDownload()
    @Binding var locationUrl: URL?
    @Binding var song: Song
    @Binding var selectedIndex: Int
    @State var checkUrlLocation:Bool?
    var customSize = CustomSize()
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var mainViewModel: MainViewModel
    @ObservedObject var songStore = SongStore()

    
    var body: some View {
        VStack(alignment: .leading){
            
            HeaderView(selectedIndex: $selectedIndex, title: "")
            
            recently
            
            feelRow
            
            ScrollView{
                LazyVStack{
                    ListRow()
                    ListRow()
                }
            }
            
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

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(song: .constant(Song()), selectedIndex: .constant(5))
//    }
//}
extension MainView{
    var recently: some View {
        VStack(alignment: .leading){
        Text("Recently")
                .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.mediumText))
        ScrollView(.horizontal){
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
    
    var feelRow: some View {
        VStack(alignment: .leading){
            Text("How do you feel today?")
                .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.mediumText))
            HStack{
                Spacer()
                
                FeelRow(imageName: "Main.Hamony", RowName: "Hamony")
                  
                Spacer()
                
                FeelRow(imageName: "Main.Calm", RowName: "Calm")
                    
                Spacer()
                
                FeelRow(imageName: "Main.Relax", RowName: "Relax")
                
                Spacer()
                
                FeelRow(imageName: "Main.Lost", RowName: "Lost")
                
                Spacer()
            }
        }
    }
}
