//
//  SplashView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//

import SwiftUI

struct SplashView: View {
    let customSize = CustomSize()
    var body: some View {
        ZStack{
            Image("General.home")
                .resizable()
            
            VStack{
                Text("Chillkra")
                    .modifier(Fonts(fontName: FontsName.JosefinBold, size:customSize.mediumText))
                
                Image("General.sun")
                    .resizable()
                    .frame(width: customSize.mainIconSize, height: customSize.mainIconSize)
                    .padding()
                
                Text("NAMASTE")
                    .modifier(Fonts(fontName: FontsName.boldKalam, size: customSize.largeText))
                    .padding()
                
                VStack{
                    Text("Minutes of chill,")
                    Text("hours of life")
                }
                .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
                
                
                NavigationLink {
                    LoginView()
                } label: {
                    Text("Login")
                        .modifier(Fonts(fontName: FontsName.JosefinBold, size:customSize.buttonText))
                        .frame(width: customSize.widthButton, height: customSize.heightButton)
                        .background(Color("General.buttonColor"))
                        .cornerRadius(6)
                }
                .padding(.top,100)
                
                HStack{
                    Text("Don't have an account?")
                        .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Sign up")
                            .modifier(Fonts(fontName: FontsName.boldKalam, size: customSize.smallText))
                    }
                }
                .padding()
                
                
            }
            .foregroundColor(Color("General.mainTextColor"))
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
