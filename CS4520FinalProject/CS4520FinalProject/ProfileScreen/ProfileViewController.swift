//
//  ProfileViewController.swift
//  CS4520FinalProject
//
//  Created by Kenny Lin on 6/23/23.
//

import UIKit
import PhotosUI
import FirebaseFirestore
import FirebaseStorage

class ProfileViewController: UIViewController {

    let profileScreenView = ProfileScreenView()
    
    var delegate : ViewController!
    
    let database = Firestore.firestore()
    
    var pickedImage : UIImage?
    
    let storage = Storage.storage()
    
    override func loadView() {
        view = profileScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = delegate.currentUser.name
        
        profileScreenView.buttonTakePhoto.menu = getMenuImagePicker()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        if let url = self.delegate.currentAuthUser?.photoURL {
            self.profileScreenView.buttonTakePhoto.loadRemoteImage(from: url)
            self.pickedImage = self.delegate.mainScreenView.buttonProfile.currentImage
        } else {
            self.profileScreenView.buttonTakePhoto.setImage(Configs.defaultPicture, for: .normal)
        }
        self.profileScreenView.labelEmail.text = "Email: \(delegate.currentAuthUser?.email ?? "Anonymous User")"
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

