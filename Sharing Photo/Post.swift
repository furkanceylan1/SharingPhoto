//
//  Post.swift
//  Sharing Photo
//
//  Created by Furkan Ceylan on 1.07.2022.
//

import Foundation

class Post{
    var email = String()
    var comment = String()
    var image = String()
    
    init(email : String, comment : String, image : String){
        self.email = email
        self.comment = comment
        self.image = image
        
    }
}
