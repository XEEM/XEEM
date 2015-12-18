//
//  ReviewCell.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    
    @IBOutlet weak var reivewTitleLabel: UILabel!    
    @IBOutlet weak var rateView: RateView!
    @IBOutlet weak var reviewDescription: UILabel!
    @IBOutlet weak var reviewerNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.rateView.notSelectedImage = UIImage(named: "ic_star_unrate_border")
        self.rateView.fullSelectedImage = UIImage(named: "ic_star")
        self.rateView.maxRating = 5;
        self.rateView.editable = false;
        self.avatarImage.image = UIImage(named: "avatar")
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(data: NSDictionary) {
        self.reivewTitleLabel.text = "review title"
        self.rateView.rating = 3.5
        self.reviewDescription.text = "Hello have a nice day"
        self.reviewerNameLabel.text = "Tan handsome"
        self.dateLabel.text = "28/03/2015"

    }

    
}
