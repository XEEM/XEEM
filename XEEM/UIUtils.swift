//
//  UIUtils.swift
//  XEEM
//
//  Created by Giao Tuan on 12/16/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

public class UIUtils {
    
    // Set round for an image view
    public static func setRoundImageView(imageView : UIImageView) -> () {
        imageView.layer.cornerRadius = imageView.frame.size.width / 2;
        imageView.clipsToBounds = true;
    }
    
    public static func setupMaterialTextField(textfield: MKTextField) -> () {
        textfield.layer.borderColor = UIColor.clearColor().CGColor
        textfield.floatingPlaceholderEnabled = true
        textfield.tintColor = UIColor.MKColor.AppMainColor
        textfield.rippleLocation = .Right
        textfield.cornerRadius = 0
        textfield.bottomBorderEnabled = true

    }
    
}
