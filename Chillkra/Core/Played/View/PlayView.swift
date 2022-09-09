//
//  PlayView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 07/09/2022.
//

import SwiftUI

struct PlayView: View {
    @Binding var selectedIndex: Int
    @EnvironmentObject var viewModel: AuthViewModel
    let customSize = CustomSize()
    var body: some View {
        ZStack(alignment: .bottom){
            Image("Play.Background")
                .resizable()
                
            VStack{
                    HeaderView(selectedIndex: $selectedIndex, title: "")
                
                name
                    .padding(.top,50)
               
                Image("Play.Progessbar")
                    .padding()
                
                time
                
                play
                
                
                action
                
                Spacer()
            }
            .navigationBarHidden(true)
            .foregroundColor(Color("General.mainTextColor"))
            .padding()
            

            
        }
        .ignoresSafeArea()
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView(selectedIndex: .constant(2))
            .environmentObject(AuthViewModel())
    }
}

extension PlayView {
    var name: some View {
        VStack{
            Text("Out of Space")
                .modifier(Fonts(fontName: FontsName.boldKalam, size: customSize.largeText))
                .padding()
            
            
            Text("Krishna")
                .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.mediumText))
                .foregroundColor(Color("Tab.ColorTab"))
        }
    }
    var time: some View {
        HStack{
            Text("17:20")
            Spacer()
            Text("46.00")
        }
        .modifier(Fonts(fontName: FontsName.kalam, size: customSize.tinyText))
        
    }
    
    var play: some View {
        HStack{
            Image(systemName: "backward.end.fill")
                .modifier(Fonts(fontName: FontsName.kalam, size: customSize.mediumText))
                .padding()
            Image(systemName: "play.circle.fill")
                .modifier(Fonts(fontName: FontsName.kalam, size: customSize.bigText))
                .padding()
            Image(systemName: "forward.end.fill")
                .modifier(Fonts(fontName: FontsName.kalam, size: customSize.mediumText))
                .padding()
        }
        .padding()
    }
    var action: some View {
        HStack{
            Image(systemName: "repeat")
                .padding()
            Image(systemName: "shuffle")
                .padding()
            Image(systemName: "moon.fill")
                .padding()
            Image(systemName: "heart")
                .padding()
        }
        .padding()
        .modifier(Fonts(fontName: FontsName.kalam, size: customSize.mediumText))
    }
}
