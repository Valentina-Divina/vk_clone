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

extension Int64 {
    func dateFromSeconds(format:String) -> Date {
        let date : NSDate! = NSDate(timeIntervalSince1970:Double(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: date as Date)
    
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return ( formatter.date( from: timeStamp ) )!
    }
}

extension String {
    func shorted(to symbols: Int) -> String {
        guard self.count > symbols else {
            return self
        }
        return self.prefix(symbols) + " ..."
    }
}
