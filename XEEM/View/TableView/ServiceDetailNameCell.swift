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
    @IBOutlet weak var rateView: RateView!
    @IBOutlet weak var currencyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.rateView.notSelectedImage = UIImage(named: "ic_star_unrate_border")
        self.rateView.fullSelectedImage = UIImage(named: "ic_star")
        self.rateView.maxRating = 5;
        self.rateView.editable = false;
        self.currencyLabel.textColor = UIColor.MKColor.Red
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(data: ShopModel) {
        if let dataURL = data.avatarURL {
            self.serviceNameImage.setImageWithURLRequest(NSURLRequest(URL: NSURL(string: dataURL)!), placeholderImage: UIImage(named: "avatar"), success: nil, failure: nil)
        } else {
            self.serviceNameImage.image = UIImage(named: "avatar")
        }
        self.nameLabel.text = data.name
        self.rateView.rating = round(Float(data.rating!))
        self.distanceLabel.text = "5km"
        self.currencyLabel.text = "FROM $5"
    }
    
}
