//
//  ListSongView.swift
//  Chillkra
//
//  Created by Van Huy on 07/10/2022.
//

import SwiftUI

struct ListSongView: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    
    @ObservedObject var songStore = SongStore()
    
    @Binding var isVisible: Bool
    
    var customSize = CustomSize()
    
    var body: some View {
        VStack(alignment: .leading){
            Button {
                isVisible.toggle()
            } label: {
                Image(systemName: "chevron.backward.circle")
                    .font(.largeTitle)
                    .foregroundColor(Color("General.mainTextColor"))
            }
            VStack(alignment: .leading){
                Text("Now Playing")
                    .modifier(Fonts(fontName: .JosefinBold, size: customSize.mediumText))
                    .padding(.top)
                    .padding(.bottom)
                Row(song: mainViewModel.song)
                    .frame(height: 100)
                    .onTapGesture {
                        self.isVisible.toggle()
                    }
            }
            .zIndex(0)
                
            
            Text("List Songs Play")
                .modifier(Fonts(fontName: .JosefinBold, size: customSize.mediumText))
                .padding(.top)
                .padding(.bottom)
            
            GeometryReader { mainView in
                
                ScrollView(.vertical,showsIndicators: false){
                    
                    LazyVStack{
                        ForEach(Array(zip(mainViewModel.songs,
                                          mainViewModel.songs.indices)),id:\.1) { song,index in
                            GeometryReader{ item in
                                
                                Button {
                                    
                                    mainViewModel.songs = mainViewModel.songs
                                    mainViewModel.song = song
                                    mainViewModel.playing = true
                                    mainViewModel.playAtIndex(index: index)
                                    self.isVisible.toggle()
                                    
                                    
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
                .onChange(of: mainViewModel.song, perform: { newValue in
                    //
                })
                .zIndex(1)
                
            }
        }
        .foregroundColor(Color("General.mainTextColor"))
        .navigationBarHidden(true)
        .padding()
        .background(Color("backgroundColor"))
    }
}

struct ListSongView_Previews: PreviewProvider {
    static var previews: some View {
        ListSongView(isVisible: .constant(true))
            .environmentObject(MainViewModel())
    }
}
