//
//  MainTableViewController.swift
//  CS4520FinalProject
//
//  Created by jacob aberasturi on 6/23/23.
//

import UIKit


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewFriendsID, for: indexPath) as! PostTableViewCell
        
        // setup labels in cell
        let post = posts[indexPath.row]
        cell.labelName.text = post.caption
//
//        if let url = post.image {
//            cell.imagePost.loadRemoteImage(from: URL(url))
//        } else {
//            cell.imagePost.image = Configs.defaultPicture
//        }
        
        return cell
    }
}
