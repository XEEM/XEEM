//
//  FilterCell.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

protocol FilterCellDelegate {
    
}


class FilterCell: UITableViewCell {

    
    @IBOutlet weak var imageFilter: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // public function
    func setSelectedImage() {
        self.selectedImageView.image = UIImage(named: "bicycle")
    }
    
    func setDefaultImage() {
        self.selectedImageView.image = UIImage(named: "ic_add_image")
    }
    
    func configData(title: NSString) {
        self.titleLabel.text = "\(title)"
        self.setDefaultImage()
        
        
    }
    
}
