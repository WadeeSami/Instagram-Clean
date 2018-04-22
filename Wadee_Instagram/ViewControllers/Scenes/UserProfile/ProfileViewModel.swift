//
//  ProfileViewModel.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/24/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import  Foundation

class ProfileViewModel{
    typealias didFetchPosts = () -> ()
    typealias didFetchUserInfo = () -> ()
    var userId : Int!
    public var userObject: User?
    
    public func getUserInfo(successHandler: @escaping (User)->()){
        UserComponent.getUserInfo(withUserId: userId, success: {user in
            successHandler(user)
            self.userObject = user
        })
    }
    
    public func unfollowUserWithId(success: @escaping ()->(), failure: @escaping ()->()){
        UserFelloshipComponent.unfollowUser(withUserId: (self.userObject?.id)!, successHandler: {
            print ("unfollowd successfully")
            self.userObject?.in_fellowship = false
            success()
        }, failureHandler: {
            failure()
        })
    }
    
    public func followUserWithId(success: @escaping ()->(), failure: @escaping ()->()){
        UserFelloshipComponent.followUser(withUserId: (self.userObject?.id)!, successHandler: {
            self.userObject?.in_fellowship = false
            success()
        }, failureHandler: {
            failure()
        })
    }
    public var postsList = [Post]()
    
    public var reloadPostsCollectionViewClosure : didFetchPosts?
    
    func fetchUserPosts(){
        UserProfileComponent.fetchUserPostImages(userId: self.userId,completion: { (postsList) in
            self.postsList = postsList!
            
            self.reloadPostsCollectionViewClosure!()
            
        })
    }
    
    
}
