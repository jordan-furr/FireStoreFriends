//
//  FirebaseSystem.swift
//  FireStoreFriends
//
//  Created by Jordan Furr on 4/23/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation
import Firebase

class FirebaseSystem {
    
    static let shared = FirebaseSystem()
    let db = Firestore.firestore()
}
