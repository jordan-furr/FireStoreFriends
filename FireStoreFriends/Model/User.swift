//
//  User.swift
//  FireStoreFriends
//
//  Created by Jordan Furr on 4/24/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation


class User {
    
    var email: String!
    var id: String!
    
    init(userEmail: String, userID: String){
        self.email = userEmail
        self.id = userID
    }
}
