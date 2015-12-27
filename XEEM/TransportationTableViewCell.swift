//
//  TransportationTableViewCell.swift
//  XEEM
//
//  Created by Anh-Tu Hoang on 12/27/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
import FontAwesome_swift

class TransportationTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    var transportation: Transportation? {
        didSet {
            name.text = transportation?.name
            
            if transportation!.type == nil {
                return
            }
            
            if transportation!.type == "Motorbike" {
                self.imageView?.image = UIImage.fontAwesomeIconWithName(FontAwesome.Motorcycle, textColor: ProfileViewController.iconColor, size: ProfileViewController.iconSize)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
