//
//  UserRepository.swift
//  VKontakte
//
//  Created by Valya on 21.08.2022.
//

import Foundation
import RealmSwift

class UserRepository {
    
    // Отдельный синглтон для методов
    static let shared = UserRepository()
    private init(){}
    private let service = Service.shared
    
    // cохранение данных друга в Realm
    func saveUserData(_ users: UserResponse) {
        
        // обработка исключений при работе с хранилищем
        do {
            // получаем доступ к хранилищу
            let realm = try Realm()
            
            // начинаем изменять хранилище
            realm.beginWrite()
            // кладем все обьекты в хранилище
            realm.add(users)
            // завершаем изменения хранилища
            try realm.commitWrite()
        } catch {
            // если произошла ошибка, выводим ее в консоль
            print(error)
        }
    }
    
    func getUserData(completion: @escaping ([MyFriends]) -> ()) {
        do {
            let realm = try Realm()
            // Вытаскиваем друзей (UserResponse) из БД
            let allFriends = realm.objects(UserResponse.self).first
            // Если друзей в БД нет
            if (allFriends == nil) {
                // Идем за друзьями на сервер
                service.getFriends { result in
                    // Конвертируем UserResponse в [MyFriends]
                    let converted = result.response?.items.map({ user in
                        MyFriends(name: user.firstName + " " + user.lastName , imageUrl: URL(string: user.photo), id: user.id)
                    }) ?? []
                    // Сохраняем полученный UserResponse в БД
                    self.saveUserData(result)
                    // Выкидываем сконвертированный [MyFriends] в контроллер
                    completion(converted)
                }
            } else {
                // Если друзья (UserResponse) в БД есть, то конвертируем в [MyFriends] и выкидываем их в контроллер
                let converted = allFriends?.response?.items.map({ user in
                    MyFriends(name: user.firstName + " " + user.lastName , imageUrl: URL(string: user.photo), id: user.id)
                }) ?? []
                completion(converted)
            }
        } catch {
            // если произошла ошибка, выводим ее в консоль
            print(error)
        }
    }
}
