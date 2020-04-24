//
//  ProfileViewController.swift
//  FireStoreFriends
//
//  Created by Jordan Furr on 4/23/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    var userCount = 0
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    let currentUser = Auth.auth().currentUser!
    let db = Firestore.firestore()
    
    override func viewWillAppear(_ animated: Bool) {
        update()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        emailLabel.text = "welcome!"
    }
    
    func update() {
        self.tabBarController?.title = "hi \(currentUser.email!) !!"
        FirebaseSystem.shared.fillUserList()
        FirebaseSystem.shared.fillUserFriendList(userID: currentUser.uid)
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        FirebaseSystem.shared.logoutAccount()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
    
}
