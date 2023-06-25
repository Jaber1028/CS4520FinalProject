//
//  PostTableViewCell.swift
//  CS4520FinalProject
//
//  Created by jacob aberasturi on 6/23/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    var wrapperCellView: UIView!
    var imageProfile: UIImageView!
    var labelName : UILabel!
    var labelDescription : UILabel!
    var imagePost : UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        
        setupWrapperCellView()
        setupImageProfile()
        setupLabelDescription()
        setupLabelName()
        setupImagePost()
        
        initConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupImageProfile() {
        imageProfile = UIImageView()
        imageProfile.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageProfile.contentMode = .scaleToFill
        imageProfile.layer.cornerRadius = 0.5 * imageProfile.bounds.size.width
        imageProfile.clipsToBounds = true
        imageProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageProfile)
    }
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.textAlignment = .left
        labelName.font = .boldSystemFont(ofSize: 19)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }
    
    func setupLabelDescription() {
        labelDescription = UILabel()
        labelDescription.textAlignment = .right
        labelDescription.font = .systemFont(ofSize: 16)
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDescription)
    }
    
    func setupImagePost() {
        imagePost = UIImageView()
        imagePost.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imagePost.contentMode = .scaleToFill
        imagePost.layer.cornerRadius = 0.5 * imagePost.bounds.size.width
        imagePost.clipsToBounds = true
        imagePost.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(imagePost)
    }
    
    func initConstraint() {
        NSLayoutConstraint.activate(
            [
                wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
                wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
                wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                
                imageProfile.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
                imageProfile.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
                imageProfile.widthAnchor.constraint(equalToConstant: 25),
                imageProfile.heightAnchor.constraint(equalTo: imageProfile.widthAnchor),
                
                labelName.centerYAnchor.constraint(equalTo: imageProfile.centerYAnchor),
                labelName.leadingAnchor.constraint(equalTo: imageProfile.trailingAnchor, constant: 8),
                
                imagePost.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
                imagePost.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor),
                imagePost.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 8),
                imagePost.widthAnchor.constraint(equalTo: wrapperCellView.widthAnchor),
                imagePost.heightAnchor.constraint(equalTo: imagePost.widthAnchor),
                
                labelDescription.topAnchor.constraint(equalTo: imagePost.bottomAnchor),
                labelDescription.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
                labelDescription.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -8),
                
            ]
        )
        
    }
}
