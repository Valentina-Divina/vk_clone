//
//  MyFriends.swift
//  VKontakte
//
//  Created by Valya on 22.06.2022.
//

import UIKit

class MyFriends {
    let id: Int
    let name: String
    let imageUrl: URL?
    var photoGallery: [UIImage]
    
    init(name: String, imageUrl: URL? = nil, photoGallery: [UIImage] = [], id: Int) {
        self.name = name
        self.imageUrl = imageUrl
        self.photoGallery = photoGallery
        self.id = id
    }
}
