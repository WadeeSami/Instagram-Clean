//
//  SimpleNetworkUtility.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/23/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
struct SimpleNetworkUtility : NetworkLayer{
    #if DEVELOPMENT
    let SERVER_URL = "http://localhost/api/v1"
    let API_TOKEN = "asfasdadasdass"
    #else
    let SERVER_URL = "http://dev.localhost.com/api/v1"
    let API_TOKEN = "fgbfkbkgbmkgbm"
    #endif
    
    static var baseUrl: URL = URL(string: "http://localhost:9000/api/v1")!
    static func performGetRequest(fromUrl url: URL, successHandler: @escaping successHandler, failureHandler: @escaping failureHandler) {
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let error = error {
                failureHandler(error)
            }else{
                successHandler(data)
            }
            
            }.resume()
    }
    
    static func performPostRequest(fromUrl url:URL, parameters params :[String:Any], successHandler: @escaping successHandler, failureHandler: @escaping failureHandler){
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: [])
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let task = URLSession.shared.dataTask(with: request){  (data, response, error) in
                if let error = error {
                    failureHandler(error)
                }else{
                    successHandler(data)
                }
                
            }
            task.resume()
        }catch let e{
            print (e)
        }
    }
    
    
    static func performMultipartRequest(fromUrl url:URL, parameters params: [String:Any], images : [Data] = [],successHandler: @escaping alamoSuccessHandler, failureHandler: @escaping failureHandler){
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append("test content".data(using: .utf8)!, withName: "content")
                multipartFormData.append(images[0],
                                         withName: "images[]",
                                         fileName: "image.jpg",
                                         mimeType: "image/jpeg")
        },
            to: url,
            headers: [:],
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.validate()
                    upload.responseJSON { response in
                        // 1.
                        guard response.result.isSuccess else {
                            failureHandler(nil)
                            return
                        }
                        
                        // 2.
                        guard let responseJSON = response.result.value as? [String: Any], let status_code = responseJSON["status_code"]  else{
                            return failureHandler(nil)
                        }
                        
                        successHandler(nil)
                        
                    }
                case .failure(let encodingError):
                    failureHandler(encodingError)
                }
                
        }
        )
        
    }
    
    static func performAlamoPostRequest(fromUrl url:URL, parameters params :[String:Any], successHandler: @escaping (alamoSuccessHandler), failureHandler: @escaping failureHandler){
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {response in
            if response.result.isSuccess{
                successHandler(response)
            }else{
                failureHandler(nil)
            }
        })
    }
    
    static func performAlamofireGetRequest(fromUrl url:URL, parameters params: [String:String], successHandler: @escaping (alamoSuccessHandler), failureHandler: @escaping failureHandler){
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).validate().responseJSON(completionHandler: {response in
            if response.result.isSuccess{
                successHandler(response)
            }else{
                failureHandler(response.error)
            }
            
        })
    }
    
}






