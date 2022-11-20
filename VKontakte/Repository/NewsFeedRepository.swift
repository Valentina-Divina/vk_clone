//
//  NewsFeedRepository.swift
//  VKontakte
//
//  Created by Valya on 18.11.2022.
//

import Foundation

class NewsFeedRepository {
    
    let service = NewsfeedService.shared
    
    var nextPageAddress: String? = nil
    
    func getPosts(comletion: @escaping (([Post]) -> ())) {
        service.getNewsFeed(completion: { feed in
            if let unwrappedFeed = feed.response { // [все посты]
                self.nextPageAddress = unwrappedFeed.nextFrom
                
                let posts : [Post] = unwrappedFeed.items?.map { item in // [один пост]
                    //ищем группу которая запостила пост
                    let group = unwrappedFeed.groups?.first(where: { group in
                        group.id == -item.sourceId
                    })
                    
                    let images: [String?] = item.attachments?.map({ attachment -> String? in
                        let tryMaxSize : SizeFriendPhotos? = attachment.photo?.sizes?.first(where: { size in
                            size.type == "y"
                        })
                        if tryMaxSize != nil {
                            return tryMaxSize?.url
                        } else {
                            return attachment.photo?.sizes?.first?.url
                        }
                    }).filter({ str in
                        str != nil
                    }) ?? []
                    
                    var views: [PostView] = []
                    let postDate: Date = Date.init(timeIntervalSince1970: TimeInterval(item.date ?? 0))
                    let formatter = DateFormatter()
                    
                    formatter.dateFormat = "dd MMMM yyyy, HH:mm"
                    
                    views.append(
                        Header(
                            timeAgo: String(formatter.string(from: postDate)),
                            createdBy: User(username: group?.name, profileImage: group?.photo))
                    )
                    
                    if(item.text != nil) {
                        views.append(Caption(caption: item.text))
                    }
                    
                    if(!images.isEmpty) {
                        views.append(Images(image: images))
                    }
                    
                    views.append(Footer(heart: item.likes?.count ?? 0, numberOfViews: String(item.views?.count ?? 0)))
                    
                    return Post.init(views: views)
                } ?? []
                
                comletion(posts)
            } else {
                comletion([])
            }
        }, startFrom: nextPageAddress)
    }
}
