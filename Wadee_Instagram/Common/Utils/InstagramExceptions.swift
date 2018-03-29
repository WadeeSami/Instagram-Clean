//
//  InstagramExceptions.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 3/1/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

/*
 
 # Expected response codes:
 - 200: OK
 - 600: Invalid input
 - 500: Internal server error
 - 401: Unauthenticated access (User is not logged in)
 - 403: Unauthorized access to resource
 
 
 # Special HTTP Resonse Code:
 
 - 601: `Invalid credentials`
 - 602: `user already exists`
 - 603: `user not verified`
 - 604: `user not allowed to resend verification code`
 - 605: `user already added to round group`
 - 606: `user already liked post`
 - 607: `NPI already used`
 - 608: `PIN Authentication failed`
 - 609: `User has already done his action on round group invitation`
 - 610: `User didn’t like the post`
 - 611: `user Email not verified`
 - 612: `User chose old password`
 - 613: `User documents not verified`
 - 614: `Invalid phone number`
 # Description Of Usual Server Responses:
 - 200 `OK` - the request was successful (some API calls may return 201 instead).
 - 201 `Created` - the request was successful and a resource was created.
 - 204 `No Content` - the request was successful but there is no representation to return (i.e. the response is empty).
 - 400 `Bad Request` - the request could not be understood or was missing required parameters.
 - 401 `Unauthorized` - authentication failed or user doesn't have permissions for requested operation.
 - 403 `Forbidden` - access denied.
 - 404 `Not Found` - resource was not found.
 - 405 `Method Not Allowed` - requested method is not supported for resource.
 
 */
import Foundation

protocol InstagramException:Error{
    var errorCode:Int {get}
    var exceptionMessage:String {get}
}


struct InvalidCredintialsException:InstagramException {
    var errorCode: Int = 601
    
    var exceptionMessage: String = "Invalid credentials"
    
    
}

struct ValidationErrorException:InstagramException {
    var errorCode: Int = 600
    
    var exceptionMessage: String = "Server Validation Error"
    
    
}




let ExceptipnsMap: [Int:Any] = [
    601: InvalidCredintialsException.self,
    600: ValidationErrorException.self
]





















