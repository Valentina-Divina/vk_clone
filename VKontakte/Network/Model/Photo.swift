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
    //    @Persisted var likes: Like
    
    enum CodingKeys: String, CodingKey {
        case sizes
        //        case likes
    }
}

class SizeFriendPhotos: Object, Decodable {
    @Persisted var url: String
}

class Like: Object, Decodable {
    @Persisted var count: Int
}
