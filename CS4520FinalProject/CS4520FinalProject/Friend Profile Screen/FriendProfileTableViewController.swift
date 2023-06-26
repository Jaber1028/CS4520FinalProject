//
//  FriendProfileTableViewController.swift
//  CS4520FinalProject
//
//  Created by Liam Evans on 6/25/23.
//

import UIKit

extension FriendProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewProfileFriendsID, for: indexPath) as! FriendProfileTableViewCell
        
        // setup labels in cell
        let post = posts[indexPath.row]
        cell.labelName.text = self.currentUser.name
        cell.labelDescription.text = post.caption
        
        if let urlProfile = self.currentUser.photo {
            cell.imageProfile.loadRemoteImage(from: urlProfile)
        } else {
            cell.imageProfile.image = Configs.defaultPicture
        }
        
        if let url = post.image {
            cell.imagePost.loadRemoteImage(from: url)
        } else {
            cell.imagePost.image = Configs.defaultPicture
        }
        
        return cell
    }
    
}
