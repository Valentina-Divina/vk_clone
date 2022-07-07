//
//  MyFriendsCell.swift
//  VKontakte
//
//  Created by Valya on 22.06.2022.
//

import UIKit

class MyFriendsCell: UITableViewCell {
    
    @IBOutlet var myFriendsLable: UILabel!
    @IBOutlet var customImageView: CustomViewFriendsList!
    
    func setup() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(sender:)))
        customImageView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func handleTapGesture(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.2,
            animations: {
            self.customImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    self.customImageView.transform = CGAffineTransform.identity
                }
            })
    }
}
