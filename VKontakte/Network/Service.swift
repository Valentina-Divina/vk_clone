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
    func getFriends() {
        let url = baseUrl + "/friends.get"
        let parameters: Parameters = [
            "access_token": token,
            "v":"5.131",
            "fields":"city,country",
            "count":"3"]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print("Friends")
            print(response)
        }
    }
    
    // получаем группы
    func getGroups() {
        let url = baseUrl + "/groups.get"
        let parameters: Parameters = [
            "access_token": token,
            "v":"5.131",
            "extended":"1",
            "count":"6"]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print("Groups")
            print(response)
        }
    }
    
    // получаем фото друга
    func getFriendPhoto() {
        let url = baseUrl + "/photos.get"
        let parameters: Parameters = [
            "access_token": token,
            "v":"5.131",
            "extended":"1",
            "owner_id": "447263487",
            "album_id":"wall",
            "count":"3"]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print("Photos")
            print(response)
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
