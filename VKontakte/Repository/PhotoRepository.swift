//
//  PhotoRepository.swift
//  VKontakte
//
//  Created by Valya on 21.08.2022.
//

import RealmSwift

class PhotoRepository {
    
    static let shared = PhotoRepository()
    private init(){}
    private let service = Service.shared
    
    // cохранение данных фото в Realm
    func savePhotoData(_ userId: Int, _ photoes: PhotosResponse) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(UserIdWithPhotos(userId, photoes))
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func getPhotoData(ownerId: Int, completion: @escaping ([URL]) -> ()) {
        do {
            let realm = try Realm()
            let friendPhotos = realm.objects(UserIdWithPhotos.self).first { friendPhotos in
                friendPhotos.userId == ownerId
            }
            if (friendPhotos == nil) {
                service.getFriendPhoto(completion: { photoesResponse in
                    let convertedPhotoes = photoesResponse.response?.items.map({ item in
                        URL(string: item.sizes.last?.url ?? "")!
                    }) ?? []
                    
                    self.savePhotoData(ownerId, photoesResponse)
                    
                    completion(convertedPhotoes)
                }, ownerId: ownerId)
            } else {
                let convertedPhotoes = friendPhotos?.photos?.response?.items.map({ item in
                    URL(string: item.sizes.last?.url ?? "")!
                }) ?? []
                completion(convertedPhotoes)
            }
        } catch {
            print(error)
        }
    }
}

class UserIdWithPhotos: Object {
    @Persisted var userId: Int
    @Persisted var photos: PhotosResponse?
    
    convenience init(_ userId: Int, _ photos: PhotosResponse) {
        self.init()
        self.photos = photos
        self.userId = userId
    }
}
