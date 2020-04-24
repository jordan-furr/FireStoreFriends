//
//  UserListTableViewController.swift
//  FireStoreFriends
//
//  Created by Jordan Furr on 4/24/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class UserListTableViewController: UITableViewController {
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.title = "all users"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirebaseSystem.shared.userList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
            //as? UserCell else { return UITableViewCell()}
        
        let email = FirebaseSystem.shared.userList[indexPath.row].email
        cell.textLabel?.text = email
        
        /*
        if (email == nil){
            print(indexPath)
        } else {
            cell.emailLabel.text = email
        }
 */
        return cell
    }
}
