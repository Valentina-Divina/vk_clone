//
//  CustomViewFriendsList.swift
//  VKontakte
//
//  Created by Valya on 26.06.2022.
//

import Foundation
import UIKit

@IBDesignable class CustomViewFriendsList: UIView {
    @IBInspectable var image: UIImage? = nil {
        didSet {
            imageView.image = self.image
        }
    }
    
    @IBInspectable var shadowColor: UIColor? = nil {
        didSet {
            stackView.layer.shadowColor = self.shadowColor?.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            stackView.layer.shadowOpacity = self.shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            stackView.layer.shadowRadius = self.shadowRadius
        }
    }
    
    private var stackView: UIStackView!
    private var imageView: UIImageView!
    
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    func setupView() {
        stackView = UIStackView()
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.cornerRadius = bounds.width/2
        imageView.layer.masksToBounds = true
        
        stackView.addSubview(imageView)
        
        
        
        
        stackView.layer.shadowOffset = CGSize(width: 5, height: 6)
        
        self.addSubview(stackView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
        imageView.frame = bounds
    }
}
