//
//  ContentView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 05/09/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject  var viewModel : AuthViewModel
    let customSize = CustomSize()
    var body: some View {
        if viewModel.userSession != nil{
            MainTabView()
        }
        else {
            SplashView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
