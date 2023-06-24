//
//  FriendRequestViewController.swift
//  CS4520FinalProject
//
//  Created by Liam Evans on 6/23/23.
//

import UIKit
import FirebaseFirestore

class FriendRequestViewController: UIViewController {
    
    let friendRequestView = FriendRequestsView()
    
    var friendRequestList = [User]()
    
    var delegate: ViewController!
    
    let database = Firestore.firestore()

    override func loadView() {
        view = friendRequestView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: patching table view delegate and data source...
        friendRequestView.tableViewFriendRequests.delegate = self
        friendRequestView.tableViewFriendRequests.dataSource = self
        
        //MARK: removing the separator line...
        friendRequestView.tableViewFriendRequests.separatorStyle = .none
        
        self.getAllFriendRequests()
        
        title = "Friend Requests"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .lightGray
        
    }
    
    func getAllFriendRequests() {
        //MARK: Observe Firestore database to display the friends list...
        self.delegate.database.collection("user").document((delegate.currentAuthUser?.email)!).collection("friendRequests")
            .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                if let documents = querySnapshot?.documents{
                    self.friendRequestList.removeAll()
                    for document in documents{
                        do{
                            let friend = try document.data(as: User.self)
                            self.friendRequestList.append(friend)
                            
                        } catch {
                            print(error)
                        }
                    }
                    // print(self.friendList)
                    self.friendRequestView.tableViewFriendRequests.reloadData()
                    print(self.friendRequestList.count)
                }
            })
    }
    
    func addFriendToFirebase(email: String) {
        let collectionFriend = self.delegate.database
            .collection("user").document(email.lowercased()).collection("friend")
        
        self.delegate.database.collection("user").addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
            if let documents = querySnapshot?.documents{
                for document in documents{
                    do{
                        let user = try document.data(as: User.self)
                        
                        if user.email.lowercased() == self.delegate.currentUser.email.lowercased() {
                            collectionFriend.addDocument(data: ["name": user.name,
                                                                "email": user.email,
                                                                "age": user.age,
                                                                "photo": user.photo?.absoluteString])
                        }
                        
                        
                    } catch {
                        print(error)
                    }
                }
            }
        })
        
        let collectionOtherFriend = self.delegate.database
            .collection("user").document((delegate.currentAuthUser?.email)!).collection("friend")
        
        self.delegate.database.collection("user").addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
            if let documents = querySnapshot?.documents{
                for document in documents{
                    do{
                        let user = try document.data(as: User.self)
                        
                        if user.email.lowercased() == email.lowercased() {
                            collectionOtherFriend.addDocument(data: ["name": user.name,
                                                                "email": user.email,
                                                                "age": user.age,
                                                                "photo": user.photo?.absoluteString])
                        }
                        
                    } catch {
                        print(error)
                    }
                }
            }
        })
    }
    
    @objc func onTapOutsideAlert(){
        self.dismiss(animated: true)
    }

    func deleteDocument(email: String) {
        self.database.collection("user").document((delegate.currentAuthUser?.email)!).collection("friendRequests").document(email.lowercased()).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }

    

}
