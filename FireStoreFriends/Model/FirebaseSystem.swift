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
    
    //base firestore reference
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
    
    //firebase reference for all 'users'
    var usersReference: CollectionReference {
        return db.collection("users")
    }
    
    //firebase ref to current user
    var currentUserReference: DocumentReference {
        let user = Auth.auth().currentUser
        let uid = user?.uid
        return usersReference.document(uid!)
    }
    
    //firebase reference to current users friend tree
    var currentUsersFriends: CollectionReference {
        return currentUserReference.collection("friends")
    }
    
    //firebase reference to current users friend request tree
    var currentUsersRequests: CollectionReference {
        return currentUserReference.collection("requests")
    }
    
   
    
    var currentUsersID: String {
        let id = Auth.auth().currentUser!.uid
        return id
    }
    
    func fillUserList(){
        userList = []
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("error", err)
            }else {
                for document in querySnapshot!.documents {
                    // print("\(document.documentID) => \(document.data())")
                    let data = document.data()
                    if data["uid"] as! String != self.currentUsersID {
                        let user = User(userEmail: data["email"] as! String, userID: data["uid"] as! String)
                        FirebaseSystem.shared.userList.append(user)
                    }
                }
                print(FirebaseSystem.shared.userList.count)
            }
        }
    }
    
    
    /*
     //gets current users object
     func getCurrentUserID(_ completion: @escaping (User) -> Void) {
     currentUserRef.addSnapshotListener { (documentSnapshot, error) in
     guard let document = documentSnapshot else {
     print ("Error fetching document: \(error!)")
     return
     }
     let source = document.metadata.hasPendingWrites ? "Local" : "Server"
     print("\(source) data: \(document.data() ?? [:])")
     //completion(document)
     }
     }
     
     //gets user object for specific idea
     func getUser(_ userID: String, completion: @escaping (User) -> Void) {
     usersRef.document(userID).addSnapshotListener { (documentSnapshot, error) in
     guard let document = documentSnapshot else {
     print ("Eror")
     return
     }
     let source = document.metadata.hasPendingWrites ? "Local" : "Server"
     print("\(source) data: \(document.data() ?? [:])")
     }
     }
     
     */
    
    
    
    
    //MARK: - REQUEST SYSTEM FUNCTIONS
    func sendRequestToUser(_ userID: String){
        usersReference.document(userID).collection("requests").document(currentUsersID).setValue(true, forKey: currentUsersID)
    }
    
    func removeFriend(_ userID: String) {
        currentUserReference.collection("friends").document(userID).delete()
    }
    
    func acceptFriendRequest(_ userID: String){
        currentUserReference.collection("requests").document(userID).delete()
        currentUserReference.collection("friends").document(userID).setValue(true, forKey: userID)
        usersReference.document(userID).collection("friends").document(currentUsersID).setValue(true, forKey: currentUsersID)
        usersReference.document(userID).collection("requests").document(currentUsersID).delete()
    }
    
    
    var userList = [User]()
    var friendList = [String]()
    
    func fillUserFriendList(userID: String){
        friendList = []
        db.collection("users").document(userID).collection("friends").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("error", err)
            }else {
                for document in querySnapshot!.documents {
                    let docID = document.documentID
                    self.friendList.append(docID)
                }
            }
        }
    }
}
/*
 }
 print(FirebaseSystem.shared.friendList.count)
 }
 }
 }
 //MARK ALL USERS
 /*
 func addUserObserver(_ update: @escaping () -> Void) {
 db.collection("users").addSnapshotListener { (documentSnapshot, error) in
 guard let document = documentSnapshot else {
 print("error")
 return
 }
 guard let data = document.data() else {
 print("document data empty")
 return
 }
 print("current data: \(data)")
 }
 }
 */
 
 
 
 
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
 
 } */
