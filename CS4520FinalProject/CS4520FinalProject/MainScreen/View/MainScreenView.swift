//
//  MainScreenView.swift
//  CS4520FinalProject
//
//  Created by Kenny Lin on 6/20/23.
//

import UIKit

class MainScreenView: UIView {
    
    var postTableView : UITableView!
    var labelText : UILabel!
    
    var buttonProfile : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupPostTableView()
        setupLabelText()
        setupButtonProfile()
        initConstraints()
    }
    
    func setupPostTableView() {
        postTableView = UITableView()
        postTableView.register(PostTableViewCell.self, forCellReuseIdentifier: Configs.tableViewFriendsID)
        postTableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(postTableView)
    }
    
    func setupLabelText() {
        labelText = UILabel()
        labelText.font = .boldSystemFont(ofSize: 14)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelText)
    }
    
    func setupButtonProfile() {
        buttonProfile = UIButton(type: .custom)
        buttonProfile.contentMode = .scaleToFill
        buttonProfile.contentHorizontalAlignment = .fill
        buttonProfile.contentVerticalAlignment = .fill
        buttonProfile.layer.cornerRadius = 0.5 * buttonProfile.bounds.size.width
        buttonProfile.clipsToBounds = true
        buttonProfile.showsMenuAsPrimaryAction = true
        buttonProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonProfile)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            labelText.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelText.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
//            buttonProfile.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
//            buttonProfile.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            buttonProfile.heightAnchor.constraint(equalToConstant: 30),
            buttonProfile.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

