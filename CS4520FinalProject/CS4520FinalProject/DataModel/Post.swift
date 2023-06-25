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
    var caption: String
    var image: URL?
    
    init(id: String? = nil, caption: String, image: URL? = nil) {
        self.id = id
        self.caption = caption
        self.image = image
    }
}
