//
//  ScalableCell.swift
//  VKontakte
//
//  Created by Valya on 12.08.2022.
//

import Foundation
import UIKit
import ScalingCarousel

class ScalableCell: ScalingCarouselCell {
    override init(frame: CGRect) {
      super.init(frame: frame)
        scaleDivisor = 2
      
      mainView = UIImageView(frame: contentView.bounds)
      contentView.addSubview(mainView)
      mainView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
          mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
          mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
          mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
          mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      ])
        mainView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
