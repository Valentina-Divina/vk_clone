//
//  NewsfeedService.swift
//  VKontakte
//
//  Created by Valya on 03.11.2022.
//

import UIKit
import Alamofire

class NewsfeedService {
    static let shared = NewsfeedService()
    private init(){}
    
    let mainService: Service = Service.shared
    
    func getNewsFeed(completion: @escaping (NewsFeed) -> (), startFrom: String?) {
        let url = mainService.baseUrl + "/newsfeed.get"
        let unwrappedStartFrom: String = startFrom ?? ""
        let parameters: Parameters = [
            "access_token": mainService.token,
            "start_from": unwrappedStartFrom,
            "v":"5.131"
        ]
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            if let data = response.data {
                let newsFeed = try! JSONDecoder().decode(NewsFeed.self, from: data)
                
                if let data = response.data {
                    let newsFeed = try! JSONDecoder().decode(NewsFeed.self, from: data)
                    DispatchQueue.main.async {
                        completion(newsFeed)
                    }
                }
            }
        }
    }
}
