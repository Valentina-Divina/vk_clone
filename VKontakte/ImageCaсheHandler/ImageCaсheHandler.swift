//
//  ImageCaсheHandler.swift
//  VKontakte
//
//  Created by Valya on 14.11.2022.
//

import Foundation
import UIKit
import Alamofire

class ImageCaсheHandler {
    
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    
    // статическое свойство, имя папки, в которой будут сохраняться изображения
    private static let pathName: String = {
        let pathName = "images"
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()
    
    // метод getFilePath получает на вход URL изображения и возвращает на его основе путь к файлу для сохранения или загрузки
    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(ImageCaсheHandler.pathName + "/" + hashName).path
    }
    
    // метод saveImageToCache сохраняет изображение в файловой системе.
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    // метод getImageFromCache загружает изображение из файловой системы
    private func getImageFromCache(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard lifeTime <= cacheLifeTime,
              let image = UIImage(contentsOfFile: fileName) else { return nil }
        
        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }
    
    // images - словарь в котором будут храниться загруженные и извлеченные из файловой системы изображения.
    private var images = [String: UIImage]()
    
    // метод loadPhoto загружает фото из сети
    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
        Alamofire.request(url).responseData(queue: DispatchQueue.global()) {
            [weak self] response in
            guard
                let data = response.data,
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.images[url] = image
            }
            self?.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                self?.container.reloadRow(atIndexPath: indexPath)
            }
        }
    }
    
    // метод photo предоставляет изображение по URL
    func photo(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? { 
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
        return image
    }
    
    private let container: DataReloadable
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
}

// MARK: - protocol DataReloadable

fileprivate protocol DataReloadable {
    func reloadRow(atIndexPath indexPath: IndexPath)
}

// MARK: - extension ImageCaсheHandler

extension ImageCaсheHandler {
    
    private class Table: DataReloadable {
        let table: UITableView
        
        init (table: UITableView) {
            self.table = table
        }
        func reloadRow(atIndexPath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    private class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        func reloadRow(atIndexPath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
}
