//
//  FullScreenView.swift
//  VKontakte
//
//  Created by Valya on 09.07.2022.
//

import UIKit

class FullScreenViewController: UIViewController {
    
    var friend: MyFriends!
    var index: Int!
    
    var baseLeftPosition = 0.0
    var baseCenterPosition = 0.0
    var baseRightPosition = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        view.addGestureRecognizer(recognizer)
        allPhotos = friend.photoGallery
        photoCurent.image = allPhotos[index]
        
        baseLeftPosition = CGFloat(0-photoCurent.frame.width)
        baseRightPosition = CGFloat(photoCurent.frame.width)
        baseCenterPosition = CGFloat(0)
        
        
        leftImage.frame = photoCurent.frame
        leftImage.layer.position.x = baseLeftPosition
        leftImage.contentMode = .scaleAspectFit
        
        rightImage.frame = photoCurent.frame
        rightImage.layer.position.x = baseRightPosition
        rightImage.contentMode = .scaleAspectFit
       
        
        view.addSubview(leftImage)
        view.addSubview(rightImage)
    }
    
    @IBOutlet weak var photoCurent: UIImageView!
    
    var allPhotos:[UIImage?] = []
    
    var leftImage = UIImageView()
    var rightImage = UIImageView()
    
    
    // MARK: - Animator
    var interactiveAnimator: UIViewPropertyAnimator!
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
        case .began:
            interactiveAnimator?.startAnimation()
            self.rightImage.frame.origin.x = baseRightPosition
            self.leftImage.frame.origin.x = baseLeftPosition
            interactiveAnimator = UIViewPropertyAnimator(
                duration: 1,
                curve: .easeInOut,
                animations: {
                    if recognizer.translation(in: self.view).x < 0 {
                        if  self.index < self.allPhotos.count - 1  {
                            self.rightImage.image = self.allPhotos[self.index + 1]
                            
                            
                            self.photoCurent.frame.origin.x = self.baseLeftPosition
            
                            
                            self.rightImage.frame.origin.x = self.baseCenterPosition
                            
                        }
                    } else {
                        if self.index != 0 {
                            self.leftImage.image = self.allPhotos[self.index - 1]
                            
                            self.photoCurent.frame.origin.x = self.baseRightPosition
                          
                            self.leftImage.frame.origin.x = self.baseCenterPosition
                        }
                        
                    }
                })
            
            interactiveAnimator.addCompletion { _ in
                self.leftImage.image = nil
                self.rightImage.image = nil
                self.photoCurent.image = self.allPhotos[self.index]
                self.leftImage.transform = .identity
                self.rightImage.transform = .identity
                self.photoCurent.transform = .identity
            }
            
            interactiveAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: self.view)
            var fraction = abs(translation.x / (view.frame.width/2))
            if interactiveAnimator?.isReversed == true { fraction *= -1 }
            print("fraction", fraction)
            interactiveAnimator.fractionComplete = fraction
            
        case .ended:
            
            if recognizer.translation(in: self.view).x < 0 {
                if  index < allPhotos.count - 1  {
                    self.index += 1
                }
            } else {
                if index != 0 {
                    self.index -= 1
                }
            }
            
            interactiveAnimator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default: break
        }
        
        
    }
}
