//
//  MainScreenView.swift
//  CS4520FinalProject
//
//  Created by Kenny Lin on 6/20/23.
//

import UIKit

class MainScreenView: UIView {
    
    var labelText : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelText()
        
        initConstraints()
    }
    
    func setupLabelText() {
        labelText = UILabel()
        labelText.font = .boldSystemFont(ofSize: 14)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelText)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            labelText.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelText.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

