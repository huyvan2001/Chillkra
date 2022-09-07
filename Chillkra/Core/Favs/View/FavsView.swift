//
//  FavsView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI

struct FavsView: View {
    let customSize = CustomSize()
    @State private var textSearch: String = ""
    var body: some View {
        VStack{
            HeaderView(imageApp: "General.sun", textApp: "Chillkra", name: "Siddhi", personImage: "Person",title: "Favorites")
            
            SearchBar(text: $textSearch)
            
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
    }
}
