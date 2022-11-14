//
//  GetGroupsOperation.swift
//  VKontakte
//
//  Created by Valya on 08.11.2022.
//

import Foundation
import Alamofire

class GetGroupsOperation: Operation {
    
    var service: Service
    var result: GroupResponse?
    
    override func main() {
        let url = service.baseUrl + "/groups.get"
        let parameters: Parameters = [
            "access_token": service.token,
            "v":"5.131",
            "extended":"1"]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            if let data = response.data {
                let groups = try! JSONDecoder().decode(GroupResponse.self, from: data)
                self.result = groups
            }
        }
    }
    
    init(service: Service) {
        self.service = service
        super.init()
    }
    
}

class ConvertGroupsOperation: Operation {
    
    var dataToConvert: GroupResponse
    var convertedResult: [GroupCollection]?
    
    override func main() {
        let converted = dataToConvert.response?.items.map({ group in
            GroupCollection(name: group.name, imageUrl: group.photo200, id: group.id)
        }) ?? []
        convertedResult = converted
    }
    
    init(dataToConvert: GroupResponse ) {
        self.dataToConvert = dataToConvert
        super.init()
    }
}
