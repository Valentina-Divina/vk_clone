//
//  FriendCollectionController.swift
//  VKontakte
//
//  Created by Valya on 23.06.2022.
//

import UIKit

private let reuseIdentifier = "FriendCollectionCellID"

class FriendCollectionController: UICollectionViewController {
    
    let columnCount = 2
    let offset: CGFloat = 2.0
    
    var friend: MyFriends? = nil
    var allPhotos: [URL] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UINib(nibName: "FriendGalleryView", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        Service.shared.getFriendPhoto(complection: { result in
            self.allPhotos = result.response?.items.map({ item in
                URL(string: item.sizes.last?.url ?? "")!
            }) ?? []
        }, ownerId: self.friend?.id ?? 0)
    }
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCollectionCellID", for: indexPath) as? FriendGalleryView else {
            preconditionFailure("Error")
        }
        cell.imageView.load(url: allPhotos[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FullScreenViewControllerID") as! FullScreenViewController
        vc.allPhotos = self.allPhotos
        vc.index = indexPath.item
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FriendCollectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize()
        let width = collectionView.frame.width / CGFloat(columnCount)
        let height = width
        print(width)
        print(height)
        let spacing = CGFloat((columnCount + 1)) * offset / CGFloat(columnCount)
        print(spacing)
        size.width = width - spacing
        size.height = height - (offset * 2)
        
        return size
    }
}
