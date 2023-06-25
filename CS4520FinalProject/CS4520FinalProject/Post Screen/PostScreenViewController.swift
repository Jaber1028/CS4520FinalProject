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
        title = "Create Post"
        
        postView.buttonTakePhoto.menu = getMenuImagePicker()
        postView.buttonCreatePost.addTarget(self,action: #selector(onCreatePost), for: .touchUpInside)
        
        
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        view.addGestureRecognizer(tapRecognizer)
        
    }
    
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    
    // **************** Needs to check for empty photo here still!
    @objc func onCreatePost(){
        if let description = postView.textFieldDesc.text {
            if description.isEmpty {
                AlertController().alertMissingField(self)
            }
                else {
                //MARK: creating a new user on Firebase...
                showActivityIndicator()
                uploadProfilePhotoToStorage()
            }
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
