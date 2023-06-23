//
//  PostTableViewCell.swift
//  CS4520FinalProject
//
//  Created by jacob aberasturi on 6/23/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    var wrapperCellView: UIView!
    var labelName : UILabel!
    var labelDate : UILabel!
    var imagePost : UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        setupWrapperCellView()
        setupLabelDate()
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
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.textAlignment = .left
        labelName.font = .boldSystemFont(ofSize: 10)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    
    func setupLabelDate() {
        labelDate = UILabel()
        labelDate.textAlignment = .right
        labelDate.font = .boldSystemFont(ofSize: 10)
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelDate)
    }
    
    func setupImagePost() {
        imagePost = UIImageView()
        imagePost.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imagePost.contentMode = .scaleToFill
        imagePost.layer.cornerRadius = 0.5 * imagePost.bounds.size.width
        imagePost.clipsToBounds = true
        imagePost.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imagePost)
    }
    
    func initConstraint() {
        NSLayoutConstraint.activate(
            [
                wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
                wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
                wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                
                imagePost.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
                imagePost.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
                imagePost.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, multiplier: 0.8),
                imagePost.widthAnchor.constraint(equalTo: self.imagePost.heightAnchor),
                
                labelName.topAnchor.constraint(equalTo: imagePost.topAnchor),
                labelName.leadingAnchor.constraint(equalTo: imagePost.trailingAnchor, constant: 16),
                
                labelDate.topAnchor.constraint(equalTo: labelName.topAnchor),
                labelDate.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
                
                wrapperCellView.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
        
    }
}
