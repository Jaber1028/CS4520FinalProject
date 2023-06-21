//
//  MainScreenView.swift
//  CS4520FinalProject
//
//  Created by Kenny Lin on 6/20/23.
//

import UIKit

class MainScreenView: UIView {
    
    var labelText : UILabel!
    
    //var buttonFriendsList : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelText()
       // setupButtonFriendsList()
        initConstraints()
    }
    
    func setupLabelText() {
        labelText = UILabel()
        labelText.font = .boldSystemFont(ofSize: 14)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelText)
    }
    
//    func setupButtonFriendsList() {
//        buttonFriendsList = UIButton(type: .system)
//        buttonFriendsList.setTitle("Friends List", for: .normal)
//        buttonFriendsList.titleLabel?.textColor = .blue
//        buttonFriendsList.setImage(UIImage(systemName: "person.3.sequence"), for: .normal)
//
//        buttonFriendsList.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(buttonFriendsList)
//    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            labelText.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelText.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
//            buttonFriendsList.topAnchor.constraint(equalTo: self.labelText.bottomAnchor, constant: 16),
//            buttonFriendsList.leadingAnchor.constraint(equalTo: self.labelText.leadingAnchor),
//            buttonFriendsList.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

