//
//  ReviewsCell.swift
//  XEEM
//
//  Created by Giao Tuan on 12/25/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class ReviewsCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var ratingView: FloatRatingView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
