//
//  QuotationCell.swift
//  XEEM
//
//  Created by Giao Tuan on 12/25/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class QuotationCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quotationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
