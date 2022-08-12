//
//  User.swift
//  VKontakte
//
//  Created by Valya on 11.08.2022.
//

import Foundation
import UIKit

struct UserStruct: Decodable {
    let response: Response
}

struct Response: Decodable { 
    let count: Int
    let items: [Item]
}

struct Item: Decodable {
    let id: Int
    let photo: String
    let firstName, lastName: String
    

    enum CodingKeys: String, CodingKey {
        case id
        case photo = "photo_200_orig"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

