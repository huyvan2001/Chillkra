//
//  SettingView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 07/09/2022.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var customSize = CustomSize()
    var body: some View {
        ZStack(alignment: .bottom){
            VStack(alignment: .leading){
                if let user = viewModel.currentUser {
                    HeaderView(imageApp: "General.sun", textApp: "Chillkra", name: user.name, personImage: "Person",title: "Settings")
                }
                
                
                
                HStack{
                    Spacer()
                    profile
                    Spacer()
                }
                .padding(.bottom)
                
                
                account
                    .padding(.bottom)
                
                notification
                    .padding(.bottom)
                
                
                other
                
                Spacer()
                
                
            }
            .navigationBarHidden(true)
            .foregroundColor(Color("General.mainTextColor"))
            .padding()
            .background(Color("backgroundColor"))
            

        }
       
        
    }
    
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SettingView()
                .environmentObject(AuthViewModel())
        }
    }
}

extension SettingView{
    var profile: some View {
        VStack{
            if let user = viewModel.currentUser {
                Image("Person")
                    .resizable()
                    .frame(width: customSize.imageprofileSize, height: customSize.imageprofileSize)
                Text(user.name)
                    .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.mediumText))
            }
        }
        
    }
    
    
    var account: some View {
        VStack(alignment: .leading){
            Text("Account")
                .foregroundColor(Color("Setting.ColorTitle"))
                .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.tinyText))
            
            VStack(alignment: .leading){
                NavigationLink {
                    //
                } label: {
                    HStack{
                        Text("Edit Profile")
                        Spacer()
                        Image(systemName: "chevron.right")
                        
                    }
                    .padding(.top)
                }
                
                
                NavigationLink {
                    //
                } label: {
                    HStack{
                        Text("Change password")
                        Spacer()
                        Image(systemName: "chevron.right")
                        
                    }
                    .padding(.top)
                }

                
                NavigationLink {
                    //
                } label: {
                    HStack{
                        Text("Change login acces")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(.top)
                }
                
                NavigationLink {
                    //
                } label: {
                    HStack{
                        Text("Language")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(.top)
                }
                
            }
            .modifier(Fonts(fontName: FontsName.boldKalam, size: customSize.smallText))
            
        }
    }
    
    
    var notification: some View {
        VStack(alignment: .leading){
            Text("Notification")
                .foregroundColor(Color("Setting.ColorTitle"))
                .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.tinyText))
                .padding(.bottom)
            VStack(alignment: .leading){
                    Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                        Text("Notification")
                    }
                    .padding(.bottom)
                Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                    Text("App Notification")
                }
                .padding(.bottom)
            }
            .modifier(Fonts(fontName: FontsName.boldKalam, size: customSize.smallText))
        }
    }
    
    
    var other: some View{
        VStack(alignment: .leading){
            Text("Other")
                .foregroundColor(Color("Setting.ColorTitle"))
                .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.tinyText))
                .padding(.bottom)
            
            Button {
                viewModel.logOut()
            } label: {
                Text("Logout")
                    .padding(.bottom)
                    .modifier(Fonts(fontName: FontsName.boldKalam, size: customSize.smallText))
            }

        }
    }
}
