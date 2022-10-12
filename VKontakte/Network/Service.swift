//
//  Service.swift
//  VKontakte
//
//  Created by Valya on 09.08.2022.
//

import Foundation
import Alamofire
import RealmSwift

class Service {
    // Отдельный синглтон для методов
    static let shared = Service()
    private init(){}

    let baseUrl = "https://api.vk.com/method/"
    let token = SessionSingleton.shared.token
    
  // MARK: - getFriends
    func getFriends(completion: @escaping (UserResponse)->()) {
        let url = baseUrl + "/friends.get"
        let parameters: Parameters = [
            "access_token": token,
            "fields":"city, photo_200_orig",
            "v":"5.131"]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            if let data = response.data {
                let user = try! JSONDecoder().decode(UserResponse.self, from: data) //  раскодировать JSON одной строкой
                completion(user)
            }
        }
    }
    
    // MARK: - getGroups
    func getGroups(completion: @escaping (GroupResponse)->()) {
        let url = baseUrl + "/groups.get"
        let parameters: Parameters = [
            "access_token": token,
            "v":"5.131",
            "extended":"1"]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            if let data = response.data {
                let groups = try! JSONDecoder().decode(GroupResponse.self, from: data)
                completion(groups)
            }
        }
    }
    
    // MARK: - getFriendPhoto
    func getFriendPhoto(completion: @escaping (PhotosResponse)->(), ownerId: Int) {

        let url = baseUrl + "/photos.get"
        let parameters: Parameters = [
            "access_token": token,
            "v":"5.131",
            "extended":"1",
            "owner_id": ownerId,
            "album_id": "profile"]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            if let data = response.data {

                let photos = try! JSONDecoder().decode(PhotosResponse.self, from: data)
                completion(photos)

            }
        }
    }
    
    // MARK: - searchGroups
    func getGroupsBySearch(query: String) {
        let url = baseUrl + "/groups.search"
        let parameters: Parameters = [
            "access_token": token,
            "v":"5.131",
            "extended":"1",
            "q": query,
            "count":"3"]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
        }
    }
}
