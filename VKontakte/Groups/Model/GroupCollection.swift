//
//  GroupCollection.swift
//  VKontakte
//
//  Created by Valya on 22.06.2022.
//

import UIKit
import RealmSwift

class GroupCollection: Object {
   @Persisted var name: String
   @Persisted var imageUrl: String?
   @Persisted var id: Int
    
   convenience init(name: String, imageUrl: String? = nil, id: Int) {
        self.init()
        self.name = name
        self.imageUrl = imageUrl
        self.id = id
    }
}
