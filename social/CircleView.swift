//
//  CircleView.swift
//  social
//
//  Created by Mickaele Perez on 6/21/17.
//  Copyright © 2017 Code. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
        
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        //put it in here because we are calculating the frame size
//        layer.cornerRadius = self.frame.width / 2
//        
//    }

}
