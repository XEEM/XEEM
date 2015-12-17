//
//  UIUtils.swift
//  XEEM
//
//  Created by Giao Tuan on 12/16/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

public class UIUtils {
    
    public static func setRoundImageView(imageView : UIImageView) -> () {
        imageView.layer.cornerRadius = imageView.frame.size.width / 2;
        imageView.clipsToBounds = true;
    }
    
}
