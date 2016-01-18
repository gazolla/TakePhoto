//
//  CustomCollectionViewCell.swift
//  TakePhoto
//
//  Created by Sebastiao Gazolla Costa Junior on 13/01/16.
//  Copyright © 2016 Sebastiao Gazolla Costa Junior. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = UIViewContentMode.ScaleAspectFit
        iv.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]

        return iv
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = self.bounds
    }

}
