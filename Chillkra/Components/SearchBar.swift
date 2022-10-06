//
//  SearchBar.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//
import SwiftUI

struct SearchBar: View {
    var customSize = CustomSize()
    @Binding var text: String
    var body: some View {
            VStack{
                TextField("Artists, songs, or podcasts",text: $text)
                    .padding(.horizontal,34)
                    .padding()
                    .overlay(
                        HStack{
                            Image(systemName: "magnifyingglass")
                            Spacer()
                            Button {
                                //
                            } label: {
                                Image(systemName: "mic")
                                    .foregroundColor(.black)
                            }

                        }
                            .padding()
                    )
            }
            .foregroundColor(Color("Search.ColorSearch"))
            .frame(width: customSize.searchBarWidth,
                   height: customSize.searchBarHeight)
            .background(Color.white)
        .cornerRadius(customSize.searchBarRadius)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
