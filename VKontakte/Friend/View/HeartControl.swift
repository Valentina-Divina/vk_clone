//
//  CustomControl.swift
//  VKontakte
//
//  Created by Valya on 26.06.2022.
//

import UIKit


@IBDesignable class HeartControl: UIControl {
    
    private var stackView: UIStackView!
    private var imageView: UIImageView!
    private var lableControl: UILabel!
    
    var heartsCounter = 0
    var hearted: Bool = false 
    
    private let heartImageSelected: UIImage! = UIImage(systemName: "heart.fill")
    private let heartImage: UIImage! = UIImage(systemName: "heart")
    
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
        self.setupView()
        self.setupGestures()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
        self.setupGestures()
    }
    
    
    private func setupView() {
        backgroundColor = .clear
        stackView = UIStackView() // создаем стек вью
        imageView = UIImageView() //создаем картинку и лебле
        lableControl = UILabel()
        lableControl.textColor = .black
        imageView.contentMode = .scaleToFill
        imageView.image = heartImage
        imageView.backgroundColor = nil
        lableControl.text = String(heartsCounter)
        
        stackView.addArrangedSubview(lableControl)
        stackView.addArrangedSubview(imageView)
        
        
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = 10
        
        self.addSubview(stackView)
    }
    
    private func setupGestures() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(click))
        addGestureRecognizer(recognizer)
    }
    
    @objc private func click() {
        hearted = !hearted
        if self.hearted {
            heartsCounter += 1
            imageView.image = heartImageSelected
        } else {
            heartsCounter -= 1
            imageView.image = heartImage
        }
        
        UIView.animate(withDuration: 0.2,
                       animations: {
            self.imageView.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
            self.imageView.transform = CGAffineTransform(rotationAngle: 0.9)
            self.lableControl.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.lableControl.alpha = 0
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.lableControl.text = String(self.heartsCounter)
                self.imageView.transform = CGAffineTransform.identity
                self.lableControl.transform = CGAffineTransform.identity
                self.lableControl.alpha = 1
            }
        })
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
}
