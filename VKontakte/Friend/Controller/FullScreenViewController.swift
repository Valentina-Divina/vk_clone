//
//  FullScreenView.swift
//  VKontakte
//
//  Created by Valya on 09.07.2022.
//

import UIKit
import ScalingCarousel

class FullScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var index: Int!
    var allPhotos:[URL?] = []
    
    var scalingCarousel: ScalingCarouselView! = nil
    
    var baseLeftPosition = 0.0
    var baseCenterPosition = 0.0
    var baseRightPosition = 0.0
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scalingCarousel = ScalingCarouselView(withFrame: view.frame, andInset: 20)
        scalingCarousel.dataSource = self
        scalingCarousel.delegate = self
        scalingCarousel.translatesAutoresizingMaskIntoConstraints = false
        
        scalingCarousel.register(ScalableCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(scalingCarousel)
        
        scalingCarousel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        scalingCarousel.heightAnchor.constraint(equalToConstant: 300).isActive = true
        scalingCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scalingCarousel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        scalingCarousel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50).isActive = true
        scalingCarousel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        scalingCarousel.scrollDirection = .horizontal
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ScalableCell else {
            preconditionFailure("Error")
        }
        
        (cell.mainView as! UIImageView).load(url: allPhotos[indexPath.row])
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if scalingCarousel != nil {
            scalingCarousel.deviceRotated()
        }
    }
    
    var onceOnly = false
    
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !onceOnly {
            let indexToScrollTo = IndexPath(item: index, section: 0)
            self.scalingCarousel.scrollToItem(at: indexToScrollTo, at: .left, animated: false)
            onceOnly = true
        }
    }
}
