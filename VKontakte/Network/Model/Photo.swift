//
//  Photo.swift
//  VKontakte
//
//  Created by Valya on 11.08.2022.
//

import RealmSwift


class PhotosResponse: Object, Decodable {
    @Persisted var response: ResponseFriendPhotos?
}

class ResponseFriendPhotos: Object, Decodable {
    @Persisted var count: Int
    @Persisted var items: List<ItemFriendPhotos>
}

class ItemFriendPhotos: Object, Decodable {
    @Persisted var sizes: List<SizeFriendPhotos>
    
    enum CodingKeys: String, CodingKey {
        case sizes
    }
}

class SizeFriendPhotos: Object, Decodable {
    @Persisted var type: String? = nil
    @Persisted var url: String
}

class Like: Object, Decodable {
    @Persisted var count: Int
}
