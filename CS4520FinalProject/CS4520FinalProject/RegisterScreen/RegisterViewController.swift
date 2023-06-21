//
//  RegisterViewController.swift
//  App12
//
//  Created by Sakib Miazi on 6/2/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()
    
    var delegate: ViewController!
    
    let childProgressView = ProgressSpinnerViewController()
    
    let database = Firestore.firestore()
    
    override func loadView() {
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        registerView.buttonRegister.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        title = "Register"
    }
    
    @objc func onRegisterTapped(){
        if let name = registerView.textFieldName.text,
           let email = registerView.textFieldEmail.text,
           let age = registerView.textFieldAge.text,
           let password = registerView.textFieldPassword.text,
           let passwordConfirm = registerView.textFieldPasswordConfirm.text {
            if name.isEmpty || email.isEmpty || age.isEmpty || password.isEmpty || passwordConfirm.isEmpty {
                AlertController().alertMissingField(self)
            } else if !isValidEmail(email) {
                AlertController().alertCustom(text: "Invalid email entered", self)
            } else if password.count < 6 {
                AlertController().alertCustom(text: "Password must be at least 6 characters", self)
            }
            else if Int(age)! < 18 {
                AlertController().alertCustom(text: "Must be older than 18 to register", self)
            } else if password != passwordConfirm {
                AlertController().alertCustom(text: "Passwords do not match", self)
            } else {
                //MARK: creating a new user on Firebase...
                
                registerNewAccount()
            }
        }
        
        func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }
    }
}
