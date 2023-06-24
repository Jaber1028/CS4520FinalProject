//
//  PostScreenViewController.swift
//  CS4520FinalProject
//
//  Created by jacob aberasturi on 6/24/23.
//

import UIKit
import PhotosUI
import FirebaseFirestore
import FirebaseStorage

class PostScreenViewController: UIViewController {
    
    
    let postView = PostScreenView()
    
    var delegate: ViewController!
    
    let childProgressView = ProgressSpinnerViewController()
    
    let database = Firestore.firestore()
    
    var pickedImage : UIImage?
    
    let storage = Storage.storage()
    
    override func loadView() {
        view = postView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        postView.buttonRegister.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        title = "Register"
        
        postView.buttonTakePhoto.menu = getMenuImagePicker()
        
        
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        view.addGestureRecognizer(tapRecognizer)
        
    }
    
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    @objc func onRegisterTapped(){
        if let name = postView.textFieldName.text,
           let email = postView.textFieldEmail.text,
           let age = postView.textFieldAge.text,
           let password = postView.textFieldPassword.text,
           let passwordConfirm = postView.textFieldPasswordConfirm.text {
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
                showActivityIndicator()
                uploadProfilePhotoToStorage()
            }
        }
        
        func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }
    }
    
    func getMenuImagePicker() -> UIMenu{
        let menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    
    //MARK: take Photo using Camera...
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    //MARK: pick Photo using Gallery...
    func pickPhotoFromGallery(){
        //MARK: Photo from Gallery...
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
}
