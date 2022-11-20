//
//  Newsfeed.swift
//  VKontakte
//
//  Created by Valya on 03.11.2022.
//

import UIKit

class NewsFeed: Decodable {
    let response: NewsFeedResponse?
    
    enum CodingKeys: String, CodingKey {
        case response
    }
}

class NewsFeedResponse: Decodable {
    let items: [NewsFeedItem]?
    let groups: [Group]?
    let nextFrom: String?
    
    enum CodingKeys: String, CodingKey {
        case items, groups
        case nextFrom = "next_from"
    }
}

class NewsFeedItem: Decodable {
    let text: String?
    let sourceId: Int64
    let date: Int64?
    let comments: NewsFeedComments?
    let likes: NewsFeedLikes?
    let reposts: NewsFeedReposts?
    let views: NewsFeedViews?
    let attachments: [NewsFeedAttachment]?
    
    enum CodingKeys: String, CodingKey {
        case text, date, comments, likes, views, reposts, attachments
        case sourceId = "source_id"
    }
}

class NewsFeedAttachment: Decodable {
    let photo: NewsFeedPhoto?
    
    enum CodingKeys: String, CodingKey {
        case photo
    }
}

class NewsFeedPhoto: Decodable {
    let sizes: [SizeFriendPhotos]?
    
    enum CodingKeys: String, CodingKey {
        case sizes
    }
}

class NewsFeedPhotoSize: Decodable {
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}

class NewsFeedComments: Decodable {
    let count: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
    }
}

class NewsFeedLikes: Decodable {
    let count: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
    }
}

class NewsFeedReposts: Decodable {
    let count: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
    }
}

class NewsFeedViews: Decodable {
    let count: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
    }
}

class Group: Decodable {
    
    let id: Int64?
    let name: String?
    let photo: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case photo = "photo_200"
    }
}
