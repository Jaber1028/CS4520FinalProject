//
//  ProfileViewController.swift
//  CS4520FinalProject
//
//  Created by Kenny Lin on 6/23/23.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileScreenView = ProfileScreenView()
    
    var delegate : ViewController!
    
    var pickedImage:UIImage?
    
    override func loadView() {
        view = profileScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = delegate.currentUser.name
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
}

