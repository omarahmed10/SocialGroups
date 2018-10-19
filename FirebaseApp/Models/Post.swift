//
//  Post.swift
//  FirebaseApp
//
//  Created by Robert Canton on 2018-02-08.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import Foundation

enum PostType : String{
    case Article = "Article"
    case Photo = "Photo"
}
class Post {
    var id:String
    var author:UserProfile
    var text:String
    var createdAt:Date
    var numLikes: Int
    var type : PostType
    var comments : [String]
    
    init(id:String, author:UserProfile,text:String,timestamp:Double,numLikes:Int,type:PostType,comments:[String]) {
        self.id = id
        self.author = author
        self.text = text
        self.createdAt = Date(timeIntervalSince1970: timestamp / 1000)
        self.type = type
        self.numLikes = numLikes
        self.comments = comments
    }
}
extension Post{
    static func type(of post: String) -> PostType {
        switch post {
        case "Article":return .Article
        case "Photo":return .Photo
        default:return .Article
        }
    }
}
