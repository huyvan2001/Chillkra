//
//  MainView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var download = SongDownload()
    @Binding var locationUrl: URL?
    @Binding var song: Song
    @Binding var selectedIndex: Int
    var customSize = CustomSize()
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var mainViewModel: MainViewModel

    
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
        self.download.fetchSongUrl(previewUrl)
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
            Text("\(Int(self.download.downloadAmount*100))%")
        ScrollView(.horizontal){
            LazyHStack{
                ForEach(mainViewModel.songs){ song in
                    Button {
                        self.song = song
                        downloadButtonTapped()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 10){
                            self.locationUrl = download.locationUrl
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
