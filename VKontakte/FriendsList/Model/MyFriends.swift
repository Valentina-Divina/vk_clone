//
//  MyFriends.swift
//  VKontakte
//
//  Created by Valya on 22.06.2022.
//

import UIKit

class MyFriends {
    let name: String
    let image: UIImage?
    var photoGallery: [UIImage]
    
    init(name: String, image: UIImage? = nil, photoGallery: [UIImage] = []) {
        self.name = name
        self.image = image
        self.photoGallery = photoGallery
    }
}
