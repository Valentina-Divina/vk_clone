//
//  PostCell.swift
//  VKontakte
//
//  Created by Valya on 04.07.2022.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var postStatusLabel: UILabel!
    @IBOutlet weak var collageView: CollageView!
    
    var post: Post! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        userImage.image = post.createdBy.profileImage
        userImage.layer.cornerRadius = userImage.frame.width/2
        usernameLabel.text = post.createdBy.username
        postTextLabel.text = post.caption
        collageView.images = post.image
        timeAgoLabel.text = post.timeAgo
        postStatusLabel.text = " \(post.numberOfViews ?? 0)"
        
    }
}
