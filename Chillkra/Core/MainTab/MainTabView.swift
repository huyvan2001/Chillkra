//
//  MainTabView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//
import SwiftUI

struct MainTabView: View {
    let customSize = CustomSize()
    @Namespace var animation
    @State private var selectedIndex = 0
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack{
            if selectedIndex == 0 {
                    MainView(selectedIndex: $selectedIndex)
                    .frame(height: 888)
            }
            else if selectedIndex == 1 {
                SearchView(selectedIndex: $selectedIndex)
                    .frame(height: 888)
            }
            else if selectedIndex == 2 {
                StatsView(selectedIndex: $selectedIndex)
                    .frame(height: 888)
            }
            else if selectedIndex == 3 {
                FavsView(selectedIndex: $selectedIndex)
                    .frame(height: 888)
            }
            else if selectedIndex == 4{
                PlayView(selectedIndex: $selectedIndex)
                    .frame(height: 888)
            }
            else if selectedIndex == 5 {
                ScrollView(.vertical){
                    VStack{
                        SettingView(selectedIndex: $selectedIndex)
                            .frame(height: 888)
                    }
                }
            }
            Spacer()
        }
        .background(Color("backgroundColor"))
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .overlay(
            VStack{
                Spacer()
//                if selectedIndex != 4{
//                    Button {
//                        self.selectedIndex = 4
//                    } label: {
//                        RowPlayer()
//                            .padding(.bottom,-6)
//                    }
//                }
                TabBar(selectedIndex: $selectedIndex)
                
            }
        )
        .ignoresSafeArea()
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(AuthViewModel())
    }
}
