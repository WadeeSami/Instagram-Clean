//
//  InstagramAPI.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/21/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation

enum InstagramAPI{
    case login
    case signup
}


extension InstagramAPI{
    
    var testingData: Data{
        switch self {
        case .login:
            return stubbedResponse(filename: "login")
        case .signup:
            return stubbedResponse(filename: "signup")
        }
        
        
    }
}


// MARK: - Private

func stubbedResponse(filename:String)->Data{
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try! Data(contentsOf: URL(fileURLWithPath: path!)))
}
