//
//  LoginView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 05/09/2022.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    let customSize = CustomSize()
    
    
    
    var body: some View {
        VStack{
            
            VStack(alignment: .leading){
                HeaderView(imageApp: "General.sun", textApp: "Chillkra", name: "", personImage: "", title: "")
                
                TitleView(typeView: .login)
                
                
                field
            }
            
            button
            
            footer
        }
        .navigationBarHidden(true)
        .foregroundColor(Color("General.mainTextColor"))
        .padding()
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(Color("backgroundColor"))
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
extension LoginView{
    
    var field: some View {
        
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text("Email")
                    .padding(.top)
                    .padding(.bottom)
                TextField("example@mail.com",text: $email)
                    .frame(width: customSize.widthTextField, height: customSize.heightTextField)
                Divider()
                    .overlay(Color("General.mainTextColor"))
                Text("Password")
                    .padding(.top)
                    .padding(.bottom)
                SecureField("example@email.com",text: $password)
                    .frame(width: customSize.widthTextField, height: customSize.heightTextField)
                Divider()
                    .overlay(Color("General.mainTextColor"))
            }
            .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
            
            
            HStack{
                Spacer()
                NavigationLink {
                    //
                } label: {
                    Text("Forgot your password?")
                }
            }
            .padding(.top)
            .modifier(Fonts(fontName: FontsName.kalam, size: customSize.mediumText))
            
        }
        .padding(.bottom)
        
    }
    var button: some View {
        Button(action: {
            viewModel.login(withEmail: email, password: password)
        }, label: {
            Text("Login")
                .modifier(Fonts(fontName: FontsName.JosefinBold, size:customSize.buttonText))
                .frame(width: customSize.widthButton, height: customSize.heightButton)
                .background(Color("General.buttonColor"))
                .cornerRadius(6)
        })
        .padding()
    }
    var footer: some View {
        VStack{
            HStack{
                Text("Don't have an account?")
                NavigationLink {
                    SignUpView()
                } label: {
                    Text("Sign up")
                        .underline()
                }

            }
            .modifier(Fonts(fontName: FontsName.kalam, size: customSize.mediumText))
            
            Spacer()
            
            Text("Or login with")
                .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
            
            
            HStack{
                Image("Google")
                    .scaledToFit()
                    .frame(width: customSize.iconfooterSize, height: customSize.iconfooterSize)
                    .padding()
                Image("Facebook")
                    .scaledToFit()
                    .frame(width: customSize.iconfooterSize, height: customSize.iconfooterSize)
                    .padding()
            }
        }
    }
}
