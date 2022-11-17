//
//  PostCell.swift
//  VKontakte
//
//  Created by Valya on 04.07.2022.
//

import UIKit
import SnapKit

class HeaderCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    var header: Header? {
        didSet {
            updateUI()
        }
    }
    func updateUI() {
        if let unwrappedHeader = header {
            userImage.image = unwrappedHeader.createdBy.profileImage
            userImage.layer.cornerRadius = userImage.frame.width/2
            usernameLabel.text = unwrappedHeader.createdBy.username
            timeAgoLabel.text = unwrappedHeader.timeAgo
        }
    }
}

class CaptionCell: UITableViewCell {
    @IBOutlet weak var postTextLabel: UILabel!
    
    var caption: Caption? {
        didSet {
            updateUI()
        }
    }
    func updateUI() {
        if let unwrappedCaption = caption {
            postTextLabel.text = unwrappedCaption.caption
        }
    }
}

class ImagesCell: UITableViewCell {
    
    @IBOutlet weak var collage: CollageView!
    
    var images: Images? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if let unwrappedImages = images {
            collage.images = unwrappedImages.image
        }
    }
}

class FooterCell: UITableViewCell {

    @IBOutlet weak var heart: HeartControl!
    @IBOutlet weak var countViews: UILabel!
    var footer: Footer? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        if let unwrappedFooter = footer {
            countViews.text = unwrappedFooter.numberOfViews
        }
    }
}
