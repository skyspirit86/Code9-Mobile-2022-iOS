//
//  LoginService.swift
//  Code9-Mobile-2022-iOS
//
//  Created by Zolt Varga on 4/24/22.
//

import Foundation

class LoginService {
    
    static func isValideUsername(text: String) -> Bool {
        return text.count > 5
    }
    
    static func isValidePassword(text: String) -> Bool {
        // least one uppercase,
        // least one digit
        // least one lowercase
        // least one symbol
        //  min 8 characters total
        
        return true
    }
}
