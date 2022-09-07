//
//  MainTabView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//
import SwiftUI

struct MainTabView: View {
    let customSize = CustomSize()
    @State private var selectedIndex = 0
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        ZStack(alignment: .bottom){
            VStack{
                if selectedIndex == 0 {
                    withAnimation(.easeInOut){
                        MainView()
                    }
                }
                else if selectedIndex == 1 {
                    withAnimation(.easeInOut){
                    SearchView()
                    }
            
                }
                else if selectedIndex == 2 {
                    withAnimation(.easeInOut){
                        StatsView()
                        
                    }
                }
                else if selectedIndex == 3 {
                    withAnimation(.easeInOut){
                    FavsView()
                    }
                }
                else if selectedIndex == 4{
                    withAnimation(.easeOut){
                    PlayView()
                    }
                }
            }
            
            Button {
                self.selectedIndex = 4
            } label: {
                RowPlayer()
                    .offset(x: 0, y: -87.5)
            }
            
            TabBar(selectedIndex: $selectedIndex)
            



        }
        .ignoresSafeArea()
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(AuthViewModel())
    }
}
