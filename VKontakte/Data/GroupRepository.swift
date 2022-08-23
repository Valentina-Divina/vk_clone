//
//  GroupRepository.swift
//  VKontakte
//
//  Created by Valya on 21.08.2022.
//

import Foundation
import RealmSwift

class GroupRepository {
    
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
}
