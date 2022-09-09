//
//  HeaderView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 05/09/2022.
//

import SwiftUI
import Kingfisher
struct HeaderView: View {
    @Binding var selectedIndex: Int
    let title: String
    var customSize = CustomSize()
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack {
            HStack{
                Image("General.sun")
                    .resizable()
                    .frame(width: customSize.icontitleSize, height:customSize.icontitleSize)
                Text("Chillkra")
                    .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.mediumText))
                Spacer()
                
                      if let user =  viewModel.currentUser {
                    HStack{
                        Text(user.name)
                            .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
                        
                        Button {
                            self.selectedIndex = 5
                        } label: {
                            if user.urlImage == "" {
                                Image("Person")
                                    .resizable()
                                    .frame(width: customSize.icontitleSize, height:customSize.icontitleSize)
                            }
                            else {
                                KFImage(URL(string: user.urlImage))
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: customSize.icontitleSize, height:customSize.icontitleSize)
                            }
                        }




                    }
                }
            }
            .padding(.top,32)
            .padding(.bottom)
            
            if title != "" {
                Text(title)
                    .padding(.top)
                    .modifier(Fonts(fontName: FontsName.boldKalam, size: customSize.largeText))
            }
        }
        .padding(.bottom)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(selectedIndex: .constant(1), title: "")
            .environmentObject(AuthViewModel())
    }
}
