//
//  NSObject+Extension.swift
//  DuplicatedApps
//
//  Created by Fakunabs on 02/10/2023.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

