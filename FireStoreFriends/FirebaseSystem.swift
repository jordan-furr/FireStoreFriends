//
//  FirebaseSystem.swift
//  FireStoreFriends
//
//  Created by Jordan Furr on 4/23/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseSystem {
    
    static let shared = FirebaseSystem()
    let db = Firestore.firestore()
    
    func signup(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error{
                print("Error in \(#function) : \(error.localizedDescription) /n--/n \(error)")
                completion(false, error)
            }
            guard let user = user else {return}
            let currentUser = Auth.auth().currentUser;
            print(" User Created \(user)")
            /*
            self.uploadImage(image: image) { (url) in
                let values = ["username": username, "email": email, "uid": currentUser?.uid, "imageURL": url]
            } */
            let values = ["email": email, "uid": currentUser?.uid]
            self.db.collection("users").document(currentUser!.uid).setData(values as [String : Any])
            completion(true, nil)
            print("Saved user to database")
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) /n--/n \(error)")
                completion(false)
                return
            }
            completion(true)
            return
        }
    }
    
    func logoutAccount() {
        try! Auth.auth().signOut()
    }
    /*
    func uploadImage(image: UIImage, completion: @escaping (String?) -> Void) {
        guard let data = image.jpegData(compressionQuality: 1.0), let uid = Auth.auth().currentUser?.uid else {print("Image failed to upload"); return}
        let imageRef = Storage.storage().reference.()child("profileImages").child("\(uid)ProfilePic")
        imageRef.putData(data, metadata: nil) { (metaData, error) in
            if error != nil {
                print("Error uploading image")
            }
            imageRef.downloadURL(completion: {(url, error) in
                if error != nil {
                    print("Error uploading image")
                }
                guard let url = url else {return}
                completion(url.absoluteString)
            })
        }
    }
 */
    
}
