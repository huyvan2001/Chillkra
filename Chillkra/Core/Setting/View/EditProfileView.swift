//
//  EditProfileView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 08/09/2022.
//

import SwiftUI
import Kingfisher
struct EditProfileView: View {
    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var viewModel: AuthViewModel
    @State var name: String = ""
    @Environment(\.presentationMode) var presentationMode
    let customSize = CustomSize()
    var body: some View {
        ZStack {
            VStack{
                HeaderView(selectedIndex: .constant(5), title: "Edit Profile")
                
                if let user = viewModel.currentUser {
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        if let profileImage = profileImage {
                            profileImage
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: customSize.imageprofileSize, height: customSize.imageprofileSize)
                            
                        }
                        else if user.urlImage == "" {
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
                    .sheet(isPresented: $showImagePicker,onDismiss: loadImage){
                        ImagePicker(selectedImage: $selectedImage)
                    }
                    
                }
                
                field
                
                
                Spacer()
                
                button
            }
            .navigationBarHidden(true)
            .foregroundColor(Color("General.mainTextColor"))
            .padding()
            .background(Color("backgroundColor"))
        }
        .ignoresSafeArea()
    }
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
            .environmentObject(AuthViewModel())
    }
}
extension EditProfileView{
    
    var field: some View {
        VStack(alignment: .leading){
            if let user = viewModel.currentUser{
                VStack(alignment: .leading){
                    Text("Name")
                        .padding(.top)
                        .padding(.bottom)
                    TextField(user.name,text: $name)
                        .frame(width: customSize.widthTextField, height: customSize.heightTextField)
                    Divider()
                        .overlay(Color("General.mainTextColor"))
                }
                .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
            }
        }
    }
    
    
    
    var button: some View {
        Button(action: {
            if name != "" {
                viewModel.editName(name)
            }
            else if let selectedImage = selectedImage, name == "" {
                viewModel.editImage(selectedImage)
            }
            else if let selectedImage = selectedImage, name != "" {
                viewModel.editImage(selectedImage)
                viewModel.editName(name)
            }
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Save Change")
                .modifier(Fonts(fontName: FontsName.JosefinBold, size:customSize.buttonText))
                .frame(width: customSize.widthButton, height: customSize.heightButton)
                .background(Color("General.buttonColor"))
                .cornerRadius(6)
        })
        .padding()
    }
}
