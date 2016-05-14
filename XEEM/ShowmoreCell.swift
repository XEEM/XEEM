//
//  ShowmoreCell.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

protocol ShowmoreCellDelegate {
    func onTapShowmoreBtn(showmoreCell: ShowmoreCell)
}

class ShowmoreCell: UITableViewCell {

    @IBOutlet weak var btnShowMore: UIButton!
    
    var delegate: ShowmoreCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.btnShowMore.setTitleColor(UIColor.MKColor.Red, forState: UIControlState.Normal)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onBtnShowMoreTapped(sender: UIButton) {
        self.delegate?.onTapShowmoreBtn(self)
    }
    
}
