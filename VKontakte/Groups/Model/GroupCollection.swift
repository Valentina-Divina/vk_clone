//
//  GroupCollection.swift
//  VKontakte
//
//  Created by Valya on 22.06.2022.
//

import UIKit

class GroupCollection {
    let name: String
    let imageUrl: URL?
    let id: Int
    
    init(name: String, imageUrl: URL? = nil, id: Int) {
        self.name = name
        self.imageUrl = imageUrl
        self.id = id
    }
}
