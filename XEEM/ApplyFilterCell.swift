//
//  ApplyFilterCell.swift
//  XEEM
//
//  Created by Giao Tuan on 12/22/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class ApplyFilterCell: UITableViewCell {

    @IBAction func applyAction(sender: UIButton) {
    }
  
    @IBOutlet weak var applyButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        applyButton.backgroundColor = UIColor.clearColor()
        applyButton.layer.cornerRadius = 5
        applyButton.layer.borderWidth = 1
        applyButton.layer.borderColor = UIColor.MKColor.AppPrimaryColor.CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
