//
//  Group.swift
//  FirebaseApp
//
//  Created by Omar Kassem on 10/19/18.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import Foundation

class Group {
    var id:String
    var nationalities : [String]
    var postsID : [String]
    var name : String
    var desc : String
    var coverURL : URL
    var profileURL : URL
    var users : [String]
    
    init(id:String , nationalities : [String], postsID : [String], name : String, desc : String, coverURL : URL, profileURL : URL , users : [String]) {
        self.id = id
        self.nationalities = nationalities
        self.postsID = postsID
        self.name = name
        self.desc = desc
        self.coverURL = coverURL
        self.profileURL = profileURL
        self.users = users
    }
}
