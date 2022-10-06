//
//  FavsView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI

struct FavsView: View {
    
    @EnvironmentObject var viewModel : AuthViewModel
    
    @Binding var selectedIndex: Int
    @State private var textSearch: String = ""
    
    let customSize = CustomSize()
    
    var body: some View {
        
        VStack{
            HeaderView(selectedIndex: $selectedIndex,
                       title: "Favorites")
            
            NavigationLink(destination: SearchSongView(selectedIndex: $selectedIndex)) {
                SearchBar(text: $textSearch)
            }
            
            favsList
            
            Spacer()
            
        }
        .navigationBarHidden(true)
        .foregroundColor(Color("General.mainTextColor"))
        .padding()
        .background(Color("backgroundColor"))
    }
}

//struct FavsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavsView(selectedIndex: .constant(1))
//            .environmentObject(AuthViewModel())
//    }
//}

extension FavsView {
    
    var favsList: some View {
        
        ScrollView(showsIndicators: false){
            
            LazyVGrid(columns:[
                .init(.adaptive(minimum:customSize.favsRowSize),spacing: 20)]){
                    FavsRow(imageName: "Favs.ChillCoffe",
                            nameSong: "Chill Coffees",
                            nameSinger: "Horus")
                    FavsRow(imageName: "Favs.LostDessert",
                            nameSong: "Lost Dessert",
                            nameSinger: "Shiva")
                    FavsRow(imageName: "Favs.City",
                            nameSong: "Cities in the sky",
                            nameSinger: "Dana")
                    FavsRow(imageName: "Favs.Spring",
                            nameSong: "Springs",
                            nameSinger: "Esus")
                    FavsRow(imageName: "Favs.ChillCoffe",
                            nameSong: "Chill Coffees",
                            nameSinger: "Horus")
                    FavsRow(imageName: "Favs.LostDessert",
                            nameSong: "Lost Dessert",
                            nameSinger: "Shiva")
                }
        }
        .padding()
        
    }
}
