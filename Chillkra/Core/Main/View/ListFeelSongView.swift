//
//  ListFeelSongView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 26/09/2022.
//

import SwiftUI

struct ListFeelSongView: View {
    @ObservedObject var download = SongDownload()
    var customSize = CustomSize()
    @ObservedObject var songStore = SongStore()
    @Environment(\.presentationMode) var presentationMode
    @Binding var locationUrl: URL?
    @Binding var selectedIndex: Int
    @State var checkUrlLocation:Bool?
    @Binding var song: Song
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
                    .modifier(Fonts(fontName: FontsName.boldKalam, size: customSize.largeText))
                Spacer()
            }
            ScrollView{
                LazyVStack{
                    ForEach(songStore.listFeelSong(idEtype: eType.idEType)){ song in
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
                            Row(song:song)
                                .padding(.bottom)
                                .padding(.leading)
                        }

                    }
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

//struct ListFeelSongView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListFeelSongView(eType: EType(idEType: "etype_Relax", nameEType: "Relax", UrlImageEType: ""))
//            .environmentObject(AuthViewModel())
//    }
//}
