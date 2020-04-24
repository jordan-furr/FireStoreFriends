//
//  SignUpViewController.swift
//  FireStoreFriends
//
//  Created by Jordan Furr on 4/23/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController{
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var confirmLabel: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    var loginMode: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "toTabBar", sender: self)
        }
    }
    
    
    
    //MARK - Helpers
    
    @IBAction func actionTapped(_ sender: Any) {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let confirm = confirmTextField.text!
        
        if loginMode == true {
            if email != "" {
                FirebaseSystem.shared.login(email: email, password: password) { (success) in
                    if success {
                        self.performSegue(withIdentifier: "toTabBar", sender: self)
                    } else {
                        print("oops")
                    }
                }
                print("logging user in")
            }
        } else {
            if email != "" && password.count >= 6 && password == confirm {
                FirebaseSystem.shared.signup(email: email, password: password) { (_, error) in
                    if error == nil {
                        self.performSegue(withIdentifier: "toTabBar", sender: self)
                    } else {
                        print("oops")
                    }
                }
                print("signing user up")
            }
        }
    }
        
    @IBAction func loginTapped(_ sender: Any) {
        loginMode = true
        confirmLabel.isHidden = true
        confirmTextField .isHidden = true
        actionButton.setTitle("log in now", for: .normal)
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        loginMode = false
        confirmLabel.isHidden = false
        confirmTextField .isHidden = false
        actionButton.setTitle("sign in now", for: .normal)
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    

}
