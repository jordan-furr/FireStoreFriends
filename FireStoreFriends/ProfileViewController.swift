//
//  ProfileViewController.swift
//  FireStoreFriends
//
//  Created by Jordan Furr on 4/23/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailLabel.text = "welcome!"
    }
}
