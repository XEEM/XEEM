//
//  InfoCell.swift
//  XEEM
//
//  Created by Giao Tuan on 12/25/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
