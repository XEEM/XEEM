//
//  QuotesTableViewCell.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class QuotesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(data: Quotes) {
        self.titleLabel.text = data.name
        if data.price != nil {
            self.price.text = "\(data.price)"
        } else {
            self.price.text = "$"
        }

    }

    
}
