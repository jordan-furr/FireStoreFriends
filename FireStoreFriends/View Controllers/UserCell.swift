//
//  UserCell.swift
//  FireStoreFriends
//
//  Created by Jordan Furr on 4/24/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    

    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    var buttonFunc: (() -> (Void))!
    
    
    @IBAction func buttonTapped(_ sender: Any) {
    }
    func setFunction(_ function: @escaping () -> Void) {
        self.buttonFunc = function
    }
}
