//
//  AddSongView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 20/09/2022.
//

import SwiftUI

struct AddSongView: View {
    
    
    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @State private var showaudioPicker: Bool = false
    @State private var song = ""
    @State private var singer = ""
    @State private var urlSong = ""
    @State private var urlImageSong = ""
    @State private var type = "type_bal"
    @State private var Etype = "etype_Hanomy"
    @State private var doneAdd: Bool = false
    
    @StateObject var songStore = SongStore()
    @ObservedObject var viewModel = AddSongViewModel()
    
    
    var customSize = CustomSize()
    
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            
            
            VStack{
                HeaderView(selectedIndex: .constant(1), title: "Add Song")
                
                
                HStack{
                    Text("Choose Image")
                    Spacer()
                }
                .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
                
                
                addImage
                
                
                field
                    .padding(.bottom)
                
                types
                    .padding(.bottom)
                
                audioPicker
                    .padding(.bottom)

                button
                
                Spacer()
                
            }
            .navigationBarHidden(true)
            .foregroundColor(Color("General.mainTextColor"))
            .padding()
            .background(Color("backgroundColor"))
        }
        .ignoresSafeArea()
    }
    
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}


struct AddSongView_Previews: PreviewProvider {
    static var previews: some View {
        AddSongView()
            .environmentObject(AuthViewModel())
            .environmentObject(MainViewModel())
    }
}


extension AddSongView {
    
    
    var addImage: some View {
        VStack{
            Button {
                showImagePicker.toggle()
            } label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .frame(width: customSize.imageprofileSize, height: customSize.imageprofileSize)
                    
                }
                else
                {
                    Image("Favs.LostDessert")
                        .resizable()
                        .frame(width: customSize.imageprofileSize, height: customSize.imageprofileSize)
                }
            }
            .sheet(isPresented: $showImagePicker,
                   onDismiss: loadImage){
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }
    
    
    var field: some View {
        VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text("Name Song")
                        .padding(.top)
                        .padding(.bottom)
                    TextField("",text: $song)
                        .frame(width: customSize.widthTextField, height: customSize.heightTextField)
                    Divider()
                        .overlay(Color("General.mainTextColor"))
                    Text("Singer")
                        .padding(.top)
                        .padding(.bottom)
                    TextField("",text: $singer)
                        .frame(width: customSize.widthTextField, height: customSize.heightTextField)
                    Divider()
                        .overlay(Color("General.mainTextColor"))
                }
                .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
        }
    }
    
    
    var types: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading){
                Text("Type:")
                    .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
                HStack{
                    ForEach(songStore.types,id:\.idType){type in
                        Button {
                            self.type = type.idType
                        } label: {
                            Text(type.nameType)
                                .frame(width: 70 , height: 25)
                                .background(Color(self.type == type.idType ?  "Search.lightPurple": "General.buttonColor"))
                                .modifier(Fonts(fontName: FontsName.kalam, size: customSize.tinyText))
                                .cornerRadius(5)
                        }
                    }
                }
                Text("Emotion Type:").modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
                HStack{
                    Spacer()
                    ForEach(songStore.eTypes,id:\.idEType){ Etype in
                        Button {
                            self.Etype = Etype.idEType
                        } label: {
                            Text(Etype.nameEType)
                                .frame(width: 70 , height: 25)
                                .background(Color(self.Etype == Etype.idEType ?  "Search.lightPurple": "General.buttonColor"))
                                .modifier(Fonts(fontName: FontsName.kalam, size: customSize.tinyText))
                                .cornerRadius(5)
                        }
                    }
                    Spacer()
                }
                
            }
            
        }
    }
    
    
    var audioPicker: some View {
        HStack{
            Text("Add Music:")
            Button {
                showaudioPicker.toggle()
            } label: {
                    Image(systemName: "folder.fill.badge.plus")
                    Spacer()
                    Text(doneAdd == true ? "Done Upload!!!!!!" : "")

            }
            .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
            .sheet(isPresented: $showaudioPicker) {
                AudioPicker(done: $doneAdd, urlSong: $urlSong)
            }
        }
    }
    
    
    var button: some View {
        
        VStack{
            
            
            
            Button(action: {
                if let selectedImage = selectedImage {
                    viewModel.saveImageSong(selectedImage) { url in
                        self.urlImageSong = url
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 6){
                    songStore.addSong(nameSong: song, urlSong: urlSong, imageSongUrl: urlImageSong, singer: singer, emotionType: Etype, lyric: "", type: type){
                        songStore.loadJSON()
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text("Add Song")
                    .modifier(Fonts(fontName: FontsName.boldKalam, size:customSize.buttonText))
                    .frame(width: customSize.widthButton, height: customSize.heightButton)
                    .background(Color("General.buttonColor"))
                    .cornerRadius(6)
            })
            
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Cancel")
                    .modifier(Fonts(fontName: FontsName.boldKalam, size:customSize.mediumText))
                    .frame(width: 100, height: 40)
                    .background(Color("General.buttonColor"))
                    .cornerRadius(6)
            }

        }
        .padding()
    }
}
