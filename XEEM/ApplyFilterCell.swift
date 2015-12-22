//
//  ApplyFilterCell.swift
//  XEEM
//
//  Created by Giao Tuan on 12/22/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class ApplyFilterCell: UITableViewCell {
    var delegate : ApplyFilterCellDelegate?
    @IBAction func applyAction(sender: UIButton) {
        applyButton.backgroundColor = UIColor.MKColor.AppMainColor
       delegate?.applyFilterCell(self)

    }
    @IBAction func highlightButton(sender: UIButton) {
        applyButton.backgroundColor = UIColor.blackColor()
    
    }
  
    @IBOutlet weak var applyButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        applyButton.backgroundColor = UIColor.MKColor.AppMainColor
        applyButton.layer.cornerRadius = 5
        applyButton.layer.borderWidth = 1
        applyButton.layer.borderColor = UIColor.MKColor.AppPrimaryColor.CGColor
        applyButton.setTitleColor(UIColor.MKColor.AppPrimaryColor, forState: .Highlighted)
    }

}
protocol ApplyFilterCellDelegate {
    func applyFilterCell(filterCell : ApplyFilterCell)
}
