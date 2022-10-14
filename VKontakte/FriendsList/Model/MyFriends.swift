//
//  MyFriends.swift
//  VKontakte
//
//  Created by Valya on 22.06.2022.
//

import UIKit
import RealmSwift

class MyFriends: Object {
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var imageUrl: String?
    
    convenience init(name: String, imageUrl: String? = nil, photoGallery: [UIImage] = [], id: Int) {
        self.init()
        self.name = name
        self.imageUrl = imageUrl
        self.id = id
    }
}
