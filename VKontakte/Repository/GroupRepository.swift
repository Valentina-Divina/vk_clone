//
//  GroupRepository.swift
//  VKontakte
//
//  Created by Valya on 21.08.2022.
//

import Foundation
import RealmSwift

class GroupRepository {
    
    static let shared = GroupRepository()
    private init(){}
    private let service = Service.shared
    
    func saveGroupData(_ group: GroupResponse) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(group)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func getGroupData(completion: @escaping ([GroupCollection]) -> ()) {
        do {
            let realm = try Realm()
            let allGroups = realm.objects(GroupResponse.self).first
            if (allGroups == nil) {
                service.getGroups { result in
                    let converted = result.response?.items.map({ group in
                        GroupCollection(name: group.name, imageUrl: URL(string: group.photo200), id: group.id)
                    }) ?? []
                    self.saveGroupData(result)
                    completion(converted)
                }
            } else {
                let converted = allGroups?.response?.items.map({ group in
                    GroupCollection(name: group.name, imageUrl: URL(string: group.photo200), id: group.id)
                }) ?? []
                completion(converted)
            }
        } catch {
            print(error)
        }
    }
}
