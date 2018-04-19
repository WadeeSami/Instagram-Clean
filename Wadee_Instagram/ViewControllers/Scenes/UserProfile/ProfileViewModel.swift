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
    var userId : Int!{
        didSet{
            UserComponent.getUserInfo(withUserId: userId, success: {user in
                DispatchQueue.main.async {
                    self.userObject = user
                    print ("fetched Successfully")
                }
            })
        }
    }
    public var userObject: User?
    
    public var postsList = [Post]()
    public var reloadPostsCollectionViewClosure : didFetchPosts?
    func fetchUserPosts(){
        UserProfileComponent.fetchUserPostImages(userId: self.userId,completion: { (postsList) in
            self.postsList = postsList!
            
            self.reloadPostsCollectionViewClosure!()
            
        })
    }
}
