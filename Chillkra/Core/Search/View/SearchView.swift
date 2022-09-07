//
//  SearchView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var textSearch: String = ""
    var customSize = CustomSize()
    var body: some View {
        VStack{
            if let user = viewModel.currentUser {
                HeaderView(imageApp: "General.sun", textApp: "Chillkra", name: user.name, personImage: "Person", title: "Search")
            }
            
            
            SearchBar(text: $textSearch)
            
            
            
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
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(AuthViewModel())
    }
}
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
            ScrollView(.horizontal){
                LazyHStack{
                    MusicRow(imageName: "Main.LostMountain", time: "15m", NameRow: "Lost Mountain", NameSinger: "Shiva")
                    MusicRow(imageName: "Main.OutOfSpace", time: "46m", NameRow: "Out Of Space", NameSinger: "Krishna")
                    MusicRow(imageName: "Main.Brahaman", time: "30m", NameRow: "Mother", NameSinger: "Vishnu")
                }
            }
        }
        .frame(height: 220)
        
    }
    
    
    
    
    
}
