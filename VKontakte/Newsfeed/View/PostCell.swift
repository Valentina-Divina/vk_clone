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
    
    var cacheHandler: ImageCaсheHandler? = nil
    var indexPath: IndexPath? = nil
    
    var header: Header? {
        didSet {
            updateUI()
        }
    }
    func updateUI() {
        if let unwrappedHeader = header {
            if let url = unwrappedHeader.createdBy.profileImage {
                self.userImage.load(url: URL(string: url))
            }
            
            userImage.layer.cornerRadius = userImage.frame.width/2
            usernameLabel.text = unwrappedHeader.createdBy.username
            timeAgoLabel.text = unwrappedHeader.timeAgo
            timeAgoLabel.invalidateIntrinsicContentSize()
        }
    }
}

class CaptionCell: UITableViewCell {
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var showMore: UIButton!
    
    @IBAction func showMoreClick(_ sender: Any) {
        if let unwrappedCaption = caption?.caption {
            caption?.isExpanded = true
            redrawCallback()
        }
    }
    
    
    var caption: Caption? {
        didSet {
            updateUI()
        }
    }
    
    var redrawCallback: () -> () = {}
    
    func updateUI() {
        if let unwrappedCaption = caption, let text = caption?.caption {
            postTextLabel.text = text
            
            if (text.count > 200 && !unwrappedCaption.isExpanded) {
                showMore.isHidden = false
                postTextLabel.numberOfLines = 3
            } else {
                showMore.isHidden = true
                postTextLabel.numberOfLines = 0
            }
            redrawCallback()
        } else {
            postTextLabel.text = ""
        }
    }
}

class ImagesCell: UITableViewCell {
    
    @IBOutlet weak var collage: CollageView!
    var cacheHandler: ImageCaсheHandler? = nil
    var indexPath: IndexPath? = nil
    var images: Images? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if let unwrappedImages = images {
            
//            DispatchQueue.global().async {
                let loaded: [UIImage?] = unwrappedImages.image.map { url in
                    if let index = self.indexPath, let unweappedUrl = url {
                        return self.cacheHandler?.photo(atIndexpath: index, byUrl: unweappedUrl)
                    } else {
                        return nil
                    }
                }.filter { item in
                    item != nil
                }
//                DispatchQueue.main.async {
                    self.collage.images = loaded
//                }
//            }
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
            heart.heartsCounter = unwrappedFooter.heart ?? 0
        }
    }
}
