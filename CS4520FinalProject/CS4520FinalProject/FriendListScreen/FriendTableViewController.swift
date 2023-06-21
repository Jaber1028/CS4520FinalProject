//
//  FriendTableViewController.swift
//  CS4520FinalProject
//
//  Created by Kenny Lin on 6/21/23.
//

import UIKit

extension FriendListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewFriendsID, for: indexPath) as! FriendTableViewCell
        
        // setup labels in cell
        let friend = friendList[indexPath.row]
        cell.labelName.text = friend.name
        cell.labelMessage.text = friend.email
        cell.labelDate.text = String(friend.age)
        cell.imageProfile.image = UIImage(systemName: "person.fill")
        
        return cell
    }
    
}