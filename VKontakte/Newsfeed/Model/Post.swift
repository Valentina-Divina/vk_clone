//
//  Post.swift
//  VKontakte
//
//  Created by Valya on 04.07.2022.
//

import UIKit

struct Post {
    
    var views: [PostView] = []
}

struct User {
    var username: String?
    var profileImage: String? // ImageUrl
}

protocol PostView {
}

struct Header: PostView {
    var timeAgo: String?
    var createdBy: User
}

struct Caption: PostView {
    var caption: String?
    var isExpanded: Bool = false
}

struct Images: PostView {
    var image: [String?] // Urls
}

struct Footer: PostView {
    var heart: Int?
    var numberOfViews: String?
}
