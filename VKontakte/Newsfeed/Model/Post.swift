//
//  Post.swift
//  VKontakte
//
//  Created by Valya on 04.07.2022.
//

import UIKit

struct Post {
    var createdBy: User
    var timeAgo: String?
    var caption: String?
    var image: [UIImage?]
    var numberOfViews: Int?
    
    static func fetchPosts() -> [Post] {
        var  posts = [Post]()
        let tavern = User(username: "Средневековая таверна", profileImage: UIImage(named: "tavern"))
        let post1 = Post(createdBy: tavern,timeAgo: "14 минут назад", caption: "Ваше здоровье, краснолюды! Пусть у вас бороды под ногами не путаются.", image: [UIImage(named: "zoltan")], numberOfViews: 56)
        
        let guts = User(username: "Guts Berserk", profileImage: UIImage(named: "guts"))
        let post2 = Post(createdBy: guts, timeAgo: "5 дней назад", caption: "Что вам нравиться больше: Самурай Джек или Аватар \u{1F914}", image: [UIImage(named: "jack"), UIImage(named: "avatar")], numberOfViews: 78)
        
        let preraphael = User(username: "Прерафаэлиты", profileImage: UIImage(named: "preraf"))
        let post3 = Post(createdBy: preraphael, timeAgo: "1 день назад", caption: "Монна Ванна» — картина английского художника-прерафаэлита Данте Габриэля Россетти, созданная в 1866 году. На данный момент картина находится в собрании галереи Тейт. текст", image: [UIImage(named: "dante" )], numberOfViews: 542)
        
        let shumerlya = User(username: "Шумерля", profileImage: UIImage(named: "shumerlya"))
        let post4 = Post(createdBy: shumerlya, timeAgo: "15 секунд назад", caption: "Жители залинейной части города Шумерля выражают руководству города и республики слова  благодарности за выделение средств на ремонт центральной в том микрорайоне дороги по улице Радищева. Еще в 2021 году здесь было уложено 600 метров асфальтового полотна с обустройством разворотной площадки у ДОСААФ. Также отремонтирован участок дороги по улице Котовского (от улицы Тургенева до улицы Радищева) протяженностью 200 метров. В том числе был покрыт асфальтом участок дороги по улице Интернациональной, с 2001 года его не ремонтировали.", image: [UIImage(named: "dorogiShumerli1"), UIImage(named: "dorogiShumerli2"), UIImage(named: "dorogiShumerli3")], numberOfViews: 1002)
        
        let misha = User(username: "Михаид Извод-Вылез", profileImage: UIImage(named: "misha"))
                         
        let post5 = Post(createdBy: misha, timeAgo: "5 дней назад", caption: "Умер ли Райан Гослинг в конце фильма Drive? Разбираться будем в следующем посте уже завтра.", image: [UIImage(named: "drive" )], numberOfViews: 552)
                         
      
                            
        
        posts.append(post1)
        posts.append(post2)
        posts.append(post3)
        posts.append(post4)
        posts.append(post5)
        
        return posts
        }
}

struct User {
    var username: String?
    var profileImage: UIImage?
}
