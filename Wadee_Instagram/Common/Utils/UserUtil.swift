//
//  UserUtil.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 4/15/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation
class UserUtil{
    static func getLoggedInUserObject()->User?{
        let userDict = AuthComponent.getLoggedInUserData()
        return userDict
    }
}
