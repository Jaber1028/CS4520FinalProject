//
//  PostScreenViewController.swift
//  CS4520FinalProject
//
//  Created by jacob aberasturi on 6/24/23.
//

import UIKit
    
extension PostScreenViewController: ProgressSpinnerDelegate{
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
