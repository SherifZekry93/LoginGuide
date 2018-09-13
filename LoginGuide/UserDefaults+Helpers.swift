//
//  UserDefaults+Helpers.swift
//  LoginGuide
//
//  Created by Sherif  Wagih on 9/3/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import Foundation

extension UserDefaults
{
    enum UserDefaultsKeys:String {
        case isLoggedIn
    }
    func setLoginValue(value:Bool)
    {
        UserDefaults.standard.set(value,forKey: UserDefaultsKeys.isLoggedIn.rawValue)
       // UserDefaults.standard.synchronize()
    }
    func isLoggedIn() -> Bool
    {
       return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
}
