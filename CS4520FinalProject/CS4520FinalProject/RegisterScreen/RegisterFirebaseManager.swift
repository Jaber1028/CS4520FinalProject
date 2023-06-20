//
//  RegisterFirebaseManager.swift
//  App12
//
//  Created by Sakib Miazi on 6/2/23.
//

import Foundation
import FirebaseAuth


extension RegisterViewController{
    
    func registerNewAccount(){
        //MARK: display the progress indicator...
        showActivityIndicator()
        //MARK: create a Firebase user with email and password...
        if let name = registerView.textFieldName.text,
           let email = registerView.textFieldEmail.text,
           let password = registerView.textFieldPassword.text{
            
            let newUser = User(name: name, email: email)
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
            .collection("users").document(newUser.email.lowercased())
        
        collectionUsers.setData(["name": newUser.name,
                                 "email": newUser.email])

    }
}
