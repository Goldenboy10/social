//
//  RoundBtn.swift
//  social
//
//  Created by Mickaele Perez on 6/8/17.
//  Copyright © 2017 Code. All rights reserved.
//

import UIKit

class RoundBtn: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        imageView?.contentMode = .scaleAspectFit
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //put it in here because we are calculating the frame size
        layer.cornerRadius = self.frame.width / 2
    }

}
