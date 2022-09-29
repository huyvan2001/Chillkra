//
//  ChangePasswordView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 08/09/2022.
//

import SwiftUI
import Kingfisher

struct ChangePasswordView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State var checkcurrentPassword: Bool = true
    @State var checkConfirmPassword: Bool = false
    @State var checklengthPassword: Bool = false
    @Binding var selectedIndex: Int
    @State var CurrentPassword: String = ""
    @State var newPassword: String = ""
    @State var confirmnewPassword: String = ""
    
    let customSize = CustomSize()
    
    var body: some View {
        ZStack {
            VStack{
                HeaderView(selectedIndex: .constant(5), title: "Change Password")
                    
                if let user = viewModel.currentUser{
                    if user.urlImage == "" {
                        Image("Person")
                            .resizable()
                            .frame(width: customSize.imageprofileSize, height: customSize.imageprofileSize)
                    }
                    else {
                        KFImage(URL(string: user.urlImage))
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: customSize.imageprofileSize, height: customSize.imageprofileSize)
                    }
                    
                }
                    
                
                field
                
                
                Spacer()
                
                button
                
                
                if checkcurrentPassword == false {
                    Text("Fail to Change Password.\nCurrent password is not correct !!!")
                        .modifier(Fonts(fontName: FontsName.kalam, size: customSize.tinyText))
                        .padding()
                        .foregroundColor(.red)
                        .frame(height: 100)
                }
                
                if checkConfirmPassword == true {
                    Text("Fail to Change Password.\nConfirm password is not correct !!!")
                        .modifier(Fonts(fontName: FontsName.kalam, size: customSize.tinyText))
                        .padding()
                        .foregroundColor(.red)
                        .frame(height: 100)
                }
                
                
                if checklengthPassword == true {
                    Text("Fail to Change Password.\nPassword length is longer than 6 !!!")
                        .modifier(Fonts(fontName: FontsName.kalam, size: customSize.tinyText))
                        .padding()
                        .foregroundColor(.red)
                }
                
                
            }
            .navigationBarHidden(true)
            .foregroundColor(Color("General.mainTextColor"))
            .padding()
            .background(Color("backgroundColor"))
        }
        .ignoresSafeArea()
    }
}


struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(selectedIndex: .constant(5))
            .environmentObject(AuthViewModel())
    }
}

extension ChangePasswordView{
    
    var field: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text("Current Password")
                    .padding(.top)
                    .padding(.bottom)
                SecureField("",text: $CurrentPassword)
                    .frame(width: customSize.widthTextField, height: customSize.heightTextField)
                Divider()
                    .overlay(Color("General.mainTextColor"))
                
                Text("New Password")
                    .padding(.top)
                    .padding(.bottom)
                SecureField("",text: $newPassword)
                    .frame(width: customSize.widthTextField, height: customSize.heightTextField)
                Divider()
                    .overlay(Color("General.mainTextColor"))
                
                
                Text("Confirm Password")
                    .padding(.top)
                    .padding(.bottom)
                SecureField("",text: $confirmnewPassword)
                    .frame(width: customSize.widthTextField, height: customSize.heightTextField)
                Divider()
                    .overlay(Color("General.mainTextColor"))
                
                
                
            }
            .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
        }
    }
    
    
    
    var button: some View {
        Button(action: {
            
            if newPassword != confirmnewPassword {
                self.checkConfirmPassword = true
            }
            if newPassword.count < 6 {
                self.checklengthPassword = true
            }
            
            if checkConfirmPassword == false && checklengthPassword == false {
                
                if let user = viewModel.currentUser {
                    viewModel.changePassword(email: user.email, currentPassword: CurrentPassword, newPassword: newPassword) { check in
                        self.checkcurrentPassword = check
                    }
                }
                if checkcurrentPassword == true {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            
            
        }, label: {
            Text("Change Password")
                .modifier(Fonts(fontName: FontsName.JosefinBold, size:customSize.buttonText))
                .frame(width: customSize.widthButton, height: customSize.heightButton)
                .background(Color("General.buttonColor"))
                .cornerRadius(6)
        })
        .padding()
    }
    
}
