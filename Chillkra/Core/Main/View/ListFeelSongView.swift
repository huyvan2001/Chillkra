//
//  ListFeelSongView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 26/09/2022.
//

import SwiftUI

struct ListFeelSongView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mainViewModel: MainViewModel
    
    @StateObject var songStore = SongStore()
    
    @Binding var selectedIndex: Int
    var customSize = CustomSize()
    var eType: EType
    
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
                Spacer()
                Text(eType.nameEType)
                    .padding()
                    .modifier(Fonts(fontName: FontsName.boldKalam,
                                    size: customSize.largeText))
                Spacer()
            }
            .zIndex(0)
            GeometryReader { mainView in
                ScrollView{
                    LazyVStack{
                        ForEach(Array(zip(songStore.listFeelSong(idEtype: eType.idEType),
                                          songStore.listFeelSong(idEtype: eType.idEType).indices)),id:\.1){ song,index in
                            GeometryReader { item in
                                
                                Button {
                                    
                                    mainViewModel.songs = songStore.listFeelSong(idEtype: eType.idEType)
                                    mainViewModel.song = song
                                    mainViewModel.playing = true
                                    mainViewModel.playAtIndex(index: index)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2)
                                    {
                                        self.selectedIndex = 4
                                    }
                                    
                                } label: {
                                    Row(song:song)
                                        .padding(.bottom)
                                        .padding(.leading)
                                        .scaleEffect(customSize.scaleValue(mainFrame: mainView.frame(in: .global).minY,
                                                                           minY: item.frame(in: .global).minY),anchor: .bottom)
                                        .opacity(customSize.scaleValue(mainFrame: mainView.frame(in: .global).minY,
                                                                       minY: item.frame(in: .global).minY))
                                }
                                
                            }
                            .frame(height: 100)
                        }
                    }
                }
                .zIndex(1)
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
        .foregroundColor(Color("General.mainTextColor"))
        .padding()
        .background(Color("backgroundColor"))
        
    }
}

//struct ListFeelSongView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListFeelSongView(eType: EType(idEType: "etype_Relax", nameEType: "Relax", UrlImageEType: ""))
//            .environmentObject(AuthViewModel())
//    }
//}
