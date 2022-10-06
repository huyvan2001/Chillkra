//
//  MainTabView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//
import SwiftUI
import UserNotifications
struct MainTabView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var mainViewModel: MainViewModel
    
    @StateObject var delegate = NotificationDelegate()
    @State var timer = Timer.publish(every: 86400, on: .current, in: .default).autoconnect()
    @State private var selectedIndex = 0
    let customSize = CustomSize()
    
    var body: some View {
        VStack{
            
            
            if selectedIndex == 0 {
                MainView(selectedIndex: $selectedIndex)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: .infinity,
                           alignment: .center)
            }
            
            
            else if selectedIndex == 1 {
                SearchView(selectedIndex: $selectedIndex)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: .infinity,
                           alignment: .center)          }
            
            
            else if selectedIndex == 2 {
                StatsView(selectedIndex: $selectedIndex)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: .infinity,
                           alignment: .center)           }
            
            
            
            else if selectedIndex == 3 {
                FavsView(selectedIndex: $selectedIndex)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: .infinity,
                           alignment: .center)
            }
            
            
            
            else if selectedIndex == 4{
                PlayView(selectedIndex: $selectedIndex)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: .infinity,
                           alignment: .center)
            }
            
            
            else if selectedIndex == 5 {
                SettingView(selectedIndex: $selectedIndex)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: .infinity,
                           alignment: .center)
                
            }
            
            
            
            Spacer()
        }
        .background(Color("backgroundColor"))
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .overlay(
            
            VStack{
                Spacer()
                if mainViewModel.song.nameSong != "" {
                    if selectedIndex != 4{
                        Button {
                            self.selectedIndex = 4
                        } label: {
                            RowPlayer()
                                .padding(.bottom,-16)
                        }
                        
                    }
                }
                TabBar(selectedIndex: $selectedIndex)
                
            }
        )
        .ignoresSafeArea()
        .onAppear(){
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { _, _ in
                
                UNUserNotificationCenter.current().delegate = delegate
            }
        }
        .onReceive(timer) { _ in
            
            mainViewModel.createNotification()
        }
    }
}

//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//            .environmentObject(AuthViewModel())
//    }
//}
