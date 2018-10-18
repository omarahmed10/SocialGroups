//
//  User.swift
//  FirebaseApp
//
//  Created by Robert Canton on 2018-02-09.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import Foundation

class UserProfile {
    var uid:String
    var username:String
    var photoURL:URL
    var nationality : String
    var email : String
    init(uid:String, username:String,photoURL:URL,country:String,email:String) {
        self.uid = uid
        self.username = username
        self.photoURL = photoURL
        self.nationality = country
        self.email = email
    }
}

