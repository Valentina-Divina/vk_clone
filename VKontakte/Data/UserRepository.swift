//
//  UserRepository.swift
//  VKontakte
//
//  Created by Valya on 21.08.2022.
//

import Foundation
import RealmSwift

class UserRepository {
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
}
