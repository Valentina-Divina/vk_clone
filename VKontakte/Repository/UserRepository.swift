//
//  UserRepository.swift
//  VKontakte
//
//  Created by Valya on 21.08.2022.
//

import RealmSwift

class UserRepository {
    
    // Отдельный синглтон для методов
    static let shared = UserRepository()
    private init(){}
    private let service = Service.shared
    
    // cохранение данных друга в Realm
    func saveUserData(_ users: [MyFriends]) {
        
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

    func getUserData() -> Results<MyFriends>? {
        var allFriends: Results<MyFriends>? = nil
        do {
            let realm = try Realm()
            // Вытаскиваем друзей из БД
            allFriends = realm.objects(MyFriends.self)
            // Если друзей в БД нет
            if (allFriends == nil || allFriends!.isEmpty) {
                // Идем за друзьями на сервер
                service.getFriends { result in
                    // Конвертируем UserResponse в [MyFriends]
                    let converted = result.response?.items.map({ user in
                        MyFriends(name: user.firstName + " " + user.lastName , imageUrl: user.photo, id: user.id)
                    }) ?? []
                    // Сохраняем полученный UserResponse в БД
                    self.saveUserData(converted)
                    // Выкидываем сконвертированный [MyFriends] в контроллер
                }
            }
        } catch {
            // если произошла ошибка, выводим ее в консоль
            print(error)
        }
        return allFriends
    }
}
