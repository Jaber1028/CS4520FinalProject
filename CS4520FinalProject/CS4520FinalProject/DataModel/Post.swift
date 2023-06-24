//
//  Post.swift
//  CS4520FinalProject
//
//  Created by Kenny Lin on 6/21/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Post: Codable{
    @DocumentID var id: String?
    var image: String
    var caption: String
    
    init(id: String? = nil, image: String, caption: String) {
        self.id = id
        self.image = image
        self.caption = caption
    }
}
