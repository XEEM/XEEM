//
//  CompactShopDetailForRequestView.swift
//  XEEM
//
//  Created by Anh-Tu Hoang on 1/5/16.
//  Copyright © 2016 JadeLe. All rights reserved.
//

import UIKit

@IBDesignable class CompactShopDetailForRequestView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var model: ShopModel!{
        didSet{
 
            titleLabel.text = model.name
            distanceLabel.text = "\(String(UIUtils.convertDistance(model?.distance)))"
            ratingView.rating = model.rating!
            
            switch model.type! {
            case "B":
                imageView.image = UIImage(named: "ic_bike")
                break
            case "C":
                imageView.image = UIImage(named: "ic_car")
                break
            case "S":
                imageView.image = UIImage(named: "ic_vespa")
                break
            case "G":
                imageView.image = UIImage(named: "ic_oil")
                break
            case "M":
                imageView.image = UIImage(named: "ic_motorbike")
                break
            default:
                imageView.image = UIImage(named: "ic_bike")
                break
            }
        }
    }
    
    @IBOutlet weak var distanceLabel: UILabel!

    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var view: UIView!
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CompactShopForRequestView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }

    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
}
