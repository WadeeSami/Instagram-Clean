//
//  Networking.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/21/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation

enum NetworkingType{
    case Stub
    case Development
    case Production
}

struct Networking{
    var NetworkingType:NetworkingType
}
