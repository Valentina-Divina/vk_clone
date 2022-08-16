//
//  Group.swift
//  VKontakte
//
//  Created by Valya on 11.08.2022.
//

import Foundation
import UIKit
import Alamofire

struct GroupStruct: Decodable {
    let response: GroupResponse
}


struct GroupResponse: Decodable {
    let count: Int
    let items: [GroupItem]
}


struct GroupItem: Decodable {
    let id: Int
    let name: String
    let photo200: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case photo200 = "photo_200"
    }
}

