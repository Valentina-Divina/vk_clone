//
//  UserRepository.swift
//  VKontakte
//
//  Created by Valya on 21.08.2022.
//

import RealmSwift
import PromiseKit
import Darwin

class UserRepository {
    
    static let shared = UserRepository()
    private init(){}
    private let service = Service.shared
    
    func saveUserData(_ users: [MyFriends]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(users)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func getUserData() -> Promise<Results<MyFriends>?> {
        return Promise { resolver in
            var allFriends: Results<MyFriends>? = nil
            do {
                let realm = try Realm()
                allFriends = realm.objects(MyFriends.self)
                if (allFriends == nil || allFriends!.isEmpty) {
                    
                    service.getFriends()
                        .map(on: .global()) { result in
                            let converted = result.response?.items.map({ user in
                                MyFriends(name: user.firstName + " " + user.lastName , imageUrl: user.photo, id: user.id)
                            }) ?? []
                            
                            self.saveUserData(converted)
                            resolver.fulfill(allFriends)
                        }.catch { error in
                            print(error)
                            resolver.fulfill(nil)
                        }
                    
                } else {
                    resolver.fulfill(allFriends)
                }
            } catch {
                print(error)
                resolver.fulfill(nil)
            }
        }
    }
}
