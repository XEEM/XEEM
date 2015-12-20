//
//  CurrencyTableViewCell.swift
//  XEEM
//
//  Created by USER on 12/19/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currency: UILabel!
    
    @IBOutlet weak var USD: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
