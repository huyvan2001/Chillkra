//
//  SignUpView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 05/09/2022.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var viewModel : AuthViewModel
    
    @State var check: Bool = true
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    let customSize = CustomSize()
    
    var body: some View {
        
        VStack{
            
            VStack(alignment: .leading){
                
                HeaderView(selectedIndex: .constant(1), title: "")
                    .padding(.bottom)
                
                TitleView(typeView: .signup)
                .padding(.bottom)
                
                field
                
            }
            
            button
            
            if check == false {
                withAnimation(.spring()) {
                    Text("Fail to Sign Up. Email exists!!!")
                        .modifier(Fonts(fontName: FontsName.kalam,
                                        size: customSize.tinyText))
                        .padding()
                        .foregroundColor(.red)

                }
            }
            
            if name.isEmpty || email.isEmpty || password.isEmpty {
                withAnimation(.spring()) {
                    Text("Please fill Information ")
                        .modifier(Fonts(fontName: FontsName.kalam,
                                        size: customSize.tinyText))
                        .padding()
                        .foregroundColor(.red)
                }
            }
            
            
            
            Spacer()
            
            footer
            
        }
        .navigationBarHidden(true)
        .foregroundColor(Color("General.mainTextColor"))
        .padding()
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(Color("backgroundColor"))
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthViewModel())
    }
}

extension SignUpView {
    var field: some View {
        
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text("Name")
                    .padding(.top)
                    .padding(.bottom)
                TextField("Buda Maitreya",text: $name)
                    .frame(width: customSize.widthTextField,
                           height: customSize.heightTextField)
                Divider()
                    .overlay(Color("General.mainTextColor"))
                
                
                Text("Email")
                    .padding(.top)
                    .padding(.bottom)
                TextField("example@mail.com",text: $email)
                    .frame(width: customSize.widthTextField,
                           height: customSize.heightTextField)
                Divider()
                    .overlay(Color("General.mainTextColor"))
                
                
                
                Text("Password")
                    .padding(.top)
                    .padding(.bottom)
                SecureField("example@email.com",text: $password)
                    .frame(width: customSize.widthTextField,
                           height: customSize.heightTextField)
                Divider()
                    .overlay(Color("General.mainTextColor"))
            }
            .modifier(Fonts(fontName: FontsName.kalam,
                            size: customSize.smallText))

            
        }
        .padding(.bottom)
        
    }
    
    var button: some View {
        Button(action: {
            
            if !name.isEmpty && !email.isEmpty && !password.isEmpty {
                viewModel.signup(withEmail: email,
                                 name: name,
                                 password: password) { check in
                    self.check = check
                }
            }
            
            
            
        }, label: {
            Text("Sign up")
                .modifier(Fonts(fontName: FontsName.JosefinBold,
                                size:customSize.buttonText))
                .frame(width: customSize.widthButton,
                       height: customSize.heightButton)
                .background(Color("General.buttonColor"))
                .cornerRadius(6)
        })
        .padding()
    }
    
    
    var footer: some View {
        VStack{
            HStack{
                Text("Already have an account?")
                NavigationLink {
                    LoginView()
                } label: {
                    Text("Login")
                        .underline()
                }

            }
            .modifier(Fonts(fontName: FontsName.kalam,
                            size: customSize.mediumText))
            
            Spacer()
            
            Text("Or login with")
                .modifier(Fonts(fontName: FontsName.kalam,
                                size: customSize.smallText))
            
            
            HStack{
                Image("Google")
                    .scaledToFit()
                    .frame(width: customSize.iconfooterSize,
                           height: customSize.iconfooterSize)
                    .padding()
                Image("Facebook")
                    .scaledToFit()
                    .frame(width: customSize.iconfooterSize,
                           height: customSize.iconfooterSize)
                    .padding()
            }
        }
    }
}

