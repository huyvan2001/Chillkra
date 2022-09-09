//
//  MainView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI

struct MainView: View {
    @Binding var selectedIndex: Int
    var customSize = CustomSize()
    @EnvironmentObject var viewModel: AuthViewModel
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
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selectedIndex: .constant(5))
    }
}
extension MainView{
    var recently: some View {
        VStack(alignment: .leading){
        Text("Recently")
                .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.mediumText))
                
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
