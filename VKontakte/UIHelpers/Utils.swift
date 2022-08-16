//
//  Utils.swift
//  VKontakte
//
//  Created by Valya on 11.08.2022.
//

import Foundation
import UIKit

extension CustomViewFriendsList {
    func load(url: URL?) {
        if let unwrappedUrl = url {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: unwrappedUrl) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}

extension UIImageView {
    func load(url: URL?) {
        if let unwrappedUrl = url {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: unwrappedUrl) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
