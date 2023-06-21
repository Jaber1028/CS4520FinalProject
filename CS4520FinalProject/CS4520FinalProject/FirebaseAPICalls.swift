//
//  FirebaseAPICalls.swift
//  CS4520FinalProject
//
//  Created by Kenny Lin on 6/21/23.
//

import Foundation
import FirebaseAuth

extension FriendListViewController {
    
    func getAllFriends() {
        //MARK: Observe Firestore database to display the friends list...
        self.delegate.database.collection("user").document((delegate.currentAuthUser?.email)!).collection("friend")
            .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                if let documents = querySnapshot?.documents{
                    self.friendList.removeAll()
                    for document in documents{
                        do{
                            let friend = try document.data(as: User.self)
                            self.friendList.append(friend)
                            
                        } catch {
                            print(error)
                        }
                    }
                    // print(self.friendList)
                    self.friendListView.tableViewFriends.reloadData()
                    print(self.friendList.count)
                }
                // self.hideActivityIndicator()
            })
    }
    
    func addFriendToFirebase(email: String) {
        let collectionFriend = self.delegate.database
            .collection("user").document((delegate.currentAuthUser?.email)!).collection("friend")
        
        
        let user = delegate.getUserDetail(email: email)
        if user != nil {
            collectionFriend.addDocument(data: ["name": user!.name,
                                                "email": user!.email,
                                                "age": user!.age])
        } else {
            print("Friend not found")
        }

        self.getAllFriends()
    }
    
    
}

extension ViewController {
    func getUserDetail(email: String) -> User? {
        var foundUser: User?
        self.database.collection("user").addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
            if let documents = querySnapshot?.documents{
                for document in documents{
                    do{
                        let user = try document.data(as: User.self)
                        print(user)
                        if user.email.lowercased() == email.lowercased() {
                            foundUser = user
                        }
                        
                    } catch {
                        print(error)
                    }
                }
            }
        })
        return foundUser
    }
}


extension RegisterViewController{
    
    func registerNewAccount(){
        //MARK: display the progress indicator...
        showActivityIndicator()
        //MARK: create a Firebase user with email and password...
        if let name = self.registerView.textFieldName.text,
           let email = self.registerView.textFieldEmail.text,
           let age = self.registerView.textFieldAge.text,
           let password = self.registerView.textFieldPassword.text{
            
            let newUser = User(name: name, email: email, age: Int(age)!)
            //Validations....
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    //MARK: the user creation is successful...
                    self.setNameOfTheUserInFirebaseAuth(name: name)
                    self.addNewUserInFirebase(newUser: newUser)
                }
                else {
                    AlertController().alertCustom(text: "Email already exists", self)
                    self.hideActivityIndicator()
                }
            })
        }
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                //MARK: the profile update is successful...
                
                //MARK: hide the progress indicator...
                self.hideActivityIndicator()
                
                //MARK: pop the current controller...
                self.navigationController?.popViewController(animated: true)
            }else{
                //MARK: there was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    func addNewUserInFirebase(newUser: User) {
        let collectionUsers = self.database
            .collection("user").document(newUser.email.lowercased())
        
        collectionUsers.setData(["name": newUser.name,
                                 "email": newUser.email,
                                 "age": newUser.age])

    }
}
