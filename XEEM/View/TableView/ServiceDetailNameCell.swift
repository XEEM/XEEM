//
//  ServiceDetailNameCell.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class ServiceDetailNameCell: UITableViewCell {

    @IBOutlet weak var serviceNameImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var serviceTypeLabel: UILabel!
    
    @IBOutlet weak var totalReview: UILabel!
    @IBOutlet weak var rateView: RateView!
    
    
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
    
    func configCell(data: NSDictionary) {
        self.serviceNameImage.image = UIImage(named: "avatar")
        self.nameLabel.text = "Service Name"
        self.serviceTypeLabel.text = "Service Type"
        self.rateView.rating = 4
        self.distanceLabel.text = "5km"
        self.totalReview.text = "1047 Reviews"
        
    }
    
}
