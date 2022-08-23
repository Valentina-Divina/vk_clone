//
//  User.swift
//  VKontakte
//
//  Created by Valya on 11.08.2022.
//

import Foundation
import RealmSwift

class UserResponse: Object, Decodable {
    @Persisted var response: Response?
}

class Response: Object, Decodable {
    @Persisted var count: Int
    @Persisted var items: List<Item>
}

class Item: Object, Decodable {
    @Persisted var id: Int
    @Persisted var photo: String
    @Persisted var firstName: String
    @Persisted var lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case photo = "photo_200_orig"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

