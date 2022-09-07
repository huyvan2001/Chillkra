//
//  FavsView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI

struct FavsView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    let customSize = CustomSize()
    @State private var textSearch: String = ""
    var body: some View {
        VStack{
            if let user = viewModel.currentUser {
                HeaderView(imageApp: "General.sun", textApp: "Chillkra", name: user.name, personImage: "Person",title: "Favorites")
            }
            
            SearchBar(text: $textSearch)
            
            favsList
            
            Spacer()
            
        }
        .navigationBarHidden(true)
        .foregroundColor(Color("General.mainTextColor"))
        .padding()
        .background(Color("backgroundColor"))
    }
}

struct FavsView_Previews: PreviewProvider {
    static var previews: some View {
        FavsView()
            .environmentObject(AuthViewModel())
    }
}

extension FavsView {
    var favsList: some View {
        ScrollView{
            LazyVGrid(columns:[
                .init(.adaptive(minimum:customSize.favsRowSize),spacing: 20)]){
                    FavsRow(imageName: "Favs.ChillCoffe", nameSong: "Chill Coffees", nameSinger: "Horus")
                    FavsRow(imageName: "Favs.LostDessert", nameSong: "Lost Dessert", nameSinger: "Shiva")
                    FavsRow(imageName: "Favs.City", nameSong: "Cities in the sky", nameSinger: "Dana")
                    FavsRow(imageName: "Favs.Spring", nameSong: "Springs", nameSinger: "Esus")
                    FavsRow(imageName: "Favs.ChillCoffe", nameSong: "Chill Coffees", nameSinger: "Horus")
                    FavsRow(imageName: "Favs.LostDessert", nameSong: "Lost Dessert", nameSinger: "Shiva")
                }
        }
        .padding()
        
    }
}
