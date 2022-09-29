//
//  TitleView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 05/09/2022.
//

import SwiftUI


enum type {
    case login
    case signup
    
    var title: String {
        switch self {
        case .login:
            return "Login"
        case .signup:
            return "Sign up"
        }
    }
    
    var description:String{
        switch self {
        case .login:
            return "Sign in for awesome chill and\nrelax experiences"
        case .signup:
            return "Sign up for free meditation chill and\nrelax experiences with music."
        }
    }
}

struct TitleView: View {
    
    var typeView: type
    let customSize = CustomSize()
    
    
    var body: some View {
        VStack(alignment:.leading){
            Text(typeView.title)
                .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.buttonText))
                .padding(.bottom,2)
            Text(typeView.description)
                .modifier(Fonts(fontName: FontsName.kalam, size: customSize.smallText))
                .frame(height: 50)
        }
        .padding(.bottom)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(typeView: .login)
    }
}
