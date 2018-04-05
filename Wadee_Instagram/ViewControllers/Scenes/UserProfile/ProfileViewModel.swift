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
    
    public var postsList = [Post]()
    public var reloadPostsCollectionViewClosure : didFetchPosts?
    func fetchUserPosts(){
        UserProfileComponent.fetchUserPostImages(completion: { (postsList) in
            self.postsList = postsList!
            print("finally\(String(describing: postsList?.count))")
            self.reloadPostsCollectionViewClosure!()
            
        })
    }
}
