//
//  GroupRepository.swift
//  VKontakte
//
//  Created by Valya on 21.08.2022.


import Foundation
import RealmSwift

class GroupRepository {
    
    static let shared = GroupRepository()
    private init(){}
    private let service = Service.shared
    
    let myOwnQueue = OperationQueue()
    
    func saveGroupData(_ group: [GroupCollection]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(group)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func getGroupData() -> Results<GroupCollection>? {
        var allGroups: Results<GroupCollection>? = nil
        do {
            let realm = try Realm()
            allGroups = realm.objects(GroupCollection.self)
            if (allGroups == nil || allGroups!.isEmpty) {
                
                let getGroupsOperation = GetGroupsOperation(service: service)
                
                getGroupsOperation.completionBlock = {
                    
                    if let result = getGroupsOperation.result {
                        let convertOperation = ConvertGroupsOperation(dataToConvert: result)
                        
                        convertOperation.completionBlock = {
                            
                            if let converted = convertOperation.convertedResult {
                                self.saveGroupData(converted)
                            }
                        }
                        self.myOwnQueue.addOperation(convertOperation)
                    }
                }
                
                myOwnQueue.addOperation(getGroupsOperation)
                
                service.getGroups { result in
                    let converted = result.response?.items.map({ group in
                        GroupCollection(name: group.name, imageUrl: group.photo200, id: group.id)
                    }) ?? []
                    self.saveGroupData(converted)
                }
            }
        } catch {
            print(error)
        }
        return allGroups
    }
    
    // Добавление группы в БД
    func addGroup(_ group: GroupCollection) {
        do {
            let realm = try Realm()
            // Оборачиваем в write{} чтобы начать транзакцию в БД
            try realm.write {
                realm.add(group)
            }
        } catch {
            print(error)
        }
    }
    
    // Удаление группы из БД
    func removeGroup(_ group: GroupCollection) {
        do {
            let realm = try Realm()
            // Оборачиваем в write{} чтобы начать транзакцию в БД
            try realm.write {
                realm.delete(group)
            }
        } catch {
            print(error)
        }
    }
}
