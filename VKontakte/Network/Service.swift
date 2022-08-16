//
//  Service.swift
//  VKontakte
//
//  Created by Valya on 09.08.2022.
//

import Foundation
import Alamofire

class Service {
    // Отдельный синглтон для методов
    static let shared = Service()
    private init(){}
    let baseUrl = "https://api.vk.com/method/"
    
    let token = SessionSingleton.shared.token
    
    // получаем друзей
    func getFriends(complection: @escaping (UserStruct)->()) {
        let url = baseUrl + "/friends.get"
        let parameters: Parameters = [
            "access_token": token,
            "fields":"city, photo_200_orig",
            "v":"5.131"]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            if let data = response.data {
                let user = try! JSONDecoder().decode(UserStruct.self, from: data) //  раскодировать JSON одной строкой
                complection(user)
            }
        }
    }
    
    // получаем группы
    func getGroups(complection: @escaping (GroupStruct)->()) {
        let url = baseUrl + "/groups.get"
        let parameters: Parameters = [
            "access_token": token,
            "v":"5.131",
            "extended":"1"]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            if let data = response.data {
                let groups = try! JSONDecoder().decode(GroupStruct.self, from: data)
                complection(groups)
            }
        }
    }
    
    // получаем фото друга
    func getFriendPhoto(complection: @escaping (PhotosStruct)->(), ownerId: Int) {
        let url = baseUrl + "/photos.get"
        let parameters: Parameters = [
            "access_token": token,
            "v":"5.131",
            "extended":"1",
            "owner_id": ownerId,
            "album_id": "profile"]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            if let data = response.data {
                let photos = try! JSONDecoder().decode(PhotosStruct.self, from: data)
                complection(photos)
            }
            
        }
    }
    
    
    // поиск групп по запросу
    func getGroupsBySearch(query: String) {
        let url = baseUrl + "/groups.search"
        let parameters: Parameters = [
            "access_token": token,
            "v":"5.131",
            "extended":"1",
            "q": query,
            "count":"3"]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print("Groups search")
            print(response)
        }
    }
}
