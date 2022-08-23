//
//  PhotoRepository.swift
//  VKontakte
//
//  Created by Valya on 21.08.2022.
//

import Foundation
import RealmSwift

class PhotoRepository {
    func savePhotoData(_ photo: PhotosResponse) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(photo)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
