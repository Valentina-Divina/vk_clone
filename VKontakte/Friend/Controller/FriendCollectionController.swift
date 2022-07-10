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
    
    //  var image: UIImage? = nil
    var friend: MyFriends? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.collectionView!.register(FriendCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(UINib(nibName: "FriendGalleryView", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return friend?.photoGallery.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCollectionCellID", for: indexPath) as? FriendGalleryView else {
            preconditionFailure("Error")
        }
        
        cell.imageView.image = friend?.photoGallery[indexPath.row]
        
        // Configure the cell
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FullScreenViewControllerID") as! FullScreenViewController
        vc.friend = self.friend
        vc.index = indexPath.item
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    
    
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
