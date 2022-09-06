//
//  TextFont.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 05/09/2022.
//

import Foundation
import SwiftUI

enum FontsName: String {
    case kalam = "Kalam-Regular"
    case boldKalam = "Kalam-Bold"
    case Josefin = "JosefinSans-Thin"
    case JosefinBold
}

struct Fonts: ViewModifier{
    var fontName: FontsName
    var size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.custom(fontName.rawValue, size: size))
    }
}
