//
//  SeeMoreCell.swift
//  XEEM
//
//  Created by Giao Tuan on 12/25/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

protocol SeeMoresCellDelegate {
    func seeMoresCell(filterCell : SeeMoresCell)
}

class SeeMoresCell: UITableViewCell {
    
    var delegate : SeeMoresCellDelegate?

    @IBAction func onSeeMoreClicked(sender: UIButton) {
        delegate?.seeMoresCell(self)
    }
    @IBOutlet weak var seeMoreLabel: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        seeMoreLabel.backgroundColor = UIColor.whiteColor()
        seeMoreLabel.layer.cornerRadius = 5
        seeMoreLabel.layer.borderWidth = 1
        seeMoreLabel.layer.borderColor = UIColor.MKColor.AppPrimaryColor.CGColor
        seeMoreLabel.setTitleColor(UIColor.MKColor.AppPrimaryColor, forState: .Highlighted)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


        // Configure the view for the selected state
    }

}
