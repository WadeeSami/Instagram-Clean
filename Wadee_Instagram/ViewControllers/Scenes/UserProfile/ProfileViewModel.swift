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
    
    var userId : Int = 11
    
    
    public var postsList = [Post]()
    public var reloadPostsCollectionViewClosure : didFetchPosts?
    
    func fetchUserPosts(){
        UserProfileComponent.fetchUserPostImages(completion: { (postsList) in
            self.postsList = postsList!
            
            self.reloadPostsCollectionViewClosure!()
            
        })
    }
}
