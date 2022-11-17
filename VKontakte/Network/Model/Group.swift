//
//  Group.swift
//  VKontakte
//
//  Created by Valya on 11.08.2022.
//

import RealmSwift

class GroupResponse: Object, Decodable {
    @Persisted var response: GroupResp?
}

class GroupResp: Object, Decodable {
    @Persisted var count: Int
    @Persisted var items: List<GroupItem>
}

class GroupItem: Object, Decodable {
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var photo200: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case photo200 = "photo_200"
    }
}

