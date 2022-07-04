//
//  CollageView.swift
//  VKontakte
//
//  Created by Valya on 04.07.2022.
//

import Foundation
import UIKit

@IBDesignable class CollageView: UIView {
    var images: [UIImage?] = []
    
    private var containerView: UICollectionView!
    
    private var itemHeight: CGFloat = 0
    private var itemWidth: CGFloat = 0
    private let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    func setupView() {
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        containerView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        containerView.isScrollEnabled = false
        containerView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        containerView?.backgroundColor = UIColor.white
        
        containerView?.dataSource = self
        containerView?.delegate = self
        
        self.addSubview(containerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.frame = bounds
        
        if (images.count == 1) {
            itemHeight = bounds.height
            itemWidth = bounds.width
        } else if (images.count == 2) {
            itemHeight = bounds.height
            itemWidth = bounds.width/2.1
        } else {
            itemHeight = bounds.height/2.1
            itemWidth = bounds.width/2.1
        }
    }
}

extension CollageView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        let imageView = UIImageView(image: images[indexPath.row])

        myCell.clipsToBounds = true
        
        if(images.count > 1 && images.count%2 != 0 && indexPath.row == images.count-1) {
            imageView.frame.size.width = itemWidth*2.1
            imageView.frame.size.height = itemHeight
            imageView.contentMode = .scaleAspectFill
        } else {
            imageView.frame.size.width = itemWidth
            imageView.frame.size.height = itemHeight
            imageView.contentMode = .scaleAspectFill
        }
        
        
        
        myCell.addSubview(imageView)
        return myCell
    }
}

extension CollageView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }
}

extension CollageView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize()
        if(images.count > 1 && images.count%2 != 0 && indexPath.row == images.count-1) {
            size.width = itemWidth*2.1
            size.height = itemHeight
        } else {
            size.width = itemWidth
            size.height = itemHeight
        }
        return size
    }
}
