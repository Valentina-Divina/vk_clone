//
//  Photo.swift
//  VKontakte
//
//  Created by Valya on 11.08.2022.
//

import Foundation
import UIKit

struct PhotosStruct: Decodable {
    let response: ResponseFriendPhotos
}

struct ResponseFriendPhotos: Decodable {
    let count: Int
    let items: [ItemFriendPhotos]
}


struct ItemFriendPhotos: Decodable {
    let sizes: [SizeFriendPhotos]
    let likes: Like

    enum CodingKeys: String, CodingKey {
        case sizes, likes
        
    }
}

struct SizeFriendPhotos: Decodable {
    let url: String
}

struct Like: Decodable {
    let count: Int
}
