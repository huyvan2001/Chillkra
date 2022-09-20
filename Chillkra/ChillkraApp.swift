//
//  ChillkraApp.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 05/09/2022.
//

import SwiftUI
import Firebase
@main
struct ChillkraApp: App {
    @StateObject var viewModel = AuthViewModel()
    @StateObject var mainViewModel = MainViewModel()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
          Database.database().reference()
      }
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
            .environmentObject(viewModel)
            .environmentObject(mainViewModel)
        }
    }
}
