//
//  AppFonts.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 12/10/2023.
//

import UIKit

struct AppFonts {
    static let fontInterBoldItalic = "Inter-BoldItalic"
    static let fontPoppinsRegular = "Poppins-Regular"
    
    static func fontInterBoldItalic(size: CGFloat) -> UIFont? {
        return UIFont(name: fontInterBoldItalic, size: size)
    }
    
    static func fontPoppinsRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: fontPoppinsRegular, size: size)
    }
}
