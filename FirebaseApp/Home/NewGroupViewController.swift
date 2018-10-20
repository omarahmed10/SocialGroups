//
//  NewGroupViewController.swift
//  FirebaseApp
//
//  Created by Omar Kassem on 10/20/18.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit
import Firebase

class NewGroupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func handleNewGroupButton() {
        
        guard let userProfile = UserService.currentUserProfile else { return }
        // Firebase code here
        
        let postRef = Database.database().reference().child("Groups").childByAutoId()
        
        let postObject = [
            "coverURL" : "",
            "desc" : "",
            "id" : postRef.key,
            "name" : "",
            "nationalities" : [userProfile.nationality],
            "postsID" : [String](),
            "profileURL" : "",
            "users" : [userProfile.uid]
            ] as [String:Any]
        
        postRef.setValue(postObject, withCompletionBlock: { error, ref in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Handle the error
            }
        })
    }

}
