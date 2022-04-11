//
//  LanguageString.swift
//  GBM
//
//  Created by Jorge Angel Sanchez Martinez on 24/04/21.
//

import Foundation

enum LanguageString: String {
    case titleMainScreen
    
    var localized: String {
        return self.rawValue.localized()
    }
}
