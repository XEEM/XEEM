//
//  ReviewCell.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var rateView: RateView!
    @IBOutlet weak var reviewDescription: UILabel!
    @IBOutlet weak var reviewerNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.rateView.notSelectedImage = UIImage(named: "ic_star_unrate_border")
        self.rateView.fullSelectedImage = UIImage(named: "ic_star")
        self.rateView.maxRating = 5;
        self.rateView.editable = false;        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(data: ReviewModel) {
        self.rateView.rating = round(Float(data.rating!))
        if let descriptions = data.descriptions {
            self.reviewDescription.text = "\(descriptions)"
        } else {
            self.reviewDescription.text = " "
        }
        
        if let fullName = data.reviewer?.fullName {
            self.reviewerNameLabel.text = "\(fullName)"
        } else {
            self.reviewerNameLabel.text = " "
        }
        self.dateLabel.text = "28/03/2015"

    }

    
}
