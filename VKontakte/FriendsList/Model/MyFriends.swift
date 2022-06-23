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
    
    init(name: String, image: UIImage? = nil) {
        self.name = name
        self.image = image
    }
}
