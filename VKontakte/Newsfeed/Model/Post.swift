//
//  Post.swift
//  VKontakte
//
//  Created by Valya on 04.07.2022.
//

import UIKit

struct Post {
    
    var views: [PostView] = []
    
    static func fetchPosts() -> [Post] {
        var posts = [Post]()
        let tavern = User(username: "Средневековая таверна", profileImage: UIImage(named: "tavern"))
        let post1 = Post(views: [
            Header(timeAgo: "14 минут назад", createdBy: tavern),
            Caption(caption: "Ваше здоровье, краснолюды! Пусть у вас бороды под ногами не путаются."),
            Images(image: [UIImage(named: "zoltan")]),
            Footer(numberOfViews: "56")
        ])
    
        
        let preraphael = User(username: "Прерафаэлиты", profileImage: UIImage(named: "preraf"))
        let post2 = Post(views: [
            Header(timeAgo: "1 день назад", createdBy: preraphael),
            Caption(caption: "Картина английского художника-прерафаэлита, созданная в 1866 году."),
            Images(image: [UIImage(named: "preraf" )]),
            Footer(numberOfViews: "542")
        ])
        
        let shumerlya = User(username: "Шумерля", profileImage: UIImage(named: "shumerlya"))
        let post3 = Post(views: [
            Header(timeAgo: "15 секунд назад", createdBy: shumerlya),
            Caption(caption: "Жители залинейной части города Шумерля выражают руководству города и республики слова  благодарности за выделение средств на ремонт центральной в том микрорайоне дороги по улице Радищева. Еще в 2021 году здесь было уложено 600 метров асфальтового полотна с обустройством разворотной площадки у ДОСААФ. В том числе был покрыт асфальтом участок дороги по улице Интернациональной, с 2001 года его не ремонтировали."),
            Images(image: [UIImage(named: "dorogiShumerli1"), UIImage(named: "dorogiShumerli2"), UIImage(named: "dorogiShumerli3")]),
            Footer(numberOfViews: "1002")
            ])
        let misha = User(username: "Михаид Извод-Вылез", profileImage: UIImage(named: "drive"))
        let post4 = Post(views: [
            Header(timeAgo: "5 дней назад", createdBy: misha),
            Caption(caption: "Умер ли Райан Гослинг в конце фильма Drive? Разбираться будем в следующем посте уже завтра."),
            Images(image: [UIImage(named: "drive" )]),
            Footer(numberOfViews: "552")
        ])
        
        posts.append(post1)
        posts.append(post2)
        posts.append(post3)
        posts.append(post4)
        
        return posts
    }
}

struct User {
    var username: String?
    var profileImage: UIImage?
}

protocol PostView {
}

struct Header: PostView {
    var timeAgo: String?
    var createdBy: User
}

struct Caption: PostView {
    var caption: String?
}

struct Images: PostView {
    var image: [UIImage?]
}

struct Footer: PostView {
    var heart: Int?
    var numberOfViews: String?
}
