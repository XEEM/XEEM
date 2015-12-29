//
//  ReceivedServiceViewController.swift
//  XEEM
//
//  Created by USER on 12/21/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
import FontAwesome_swift

class ReceivedServiceViewController: UIViewController {

    @IBOutlet weak var requestAccepetedTitleLabel: UILabel!
    
    @IBOutlet weak var imageRepairService: UIImageView!
    
    @IBOutlet weak var repairServiceLabel: UILabel!
    
    @IBOutlet weak var ratingView: FloatRatingView!
    
    @IBOutlet weak var receivedServiceBtn: UIButton!
    
    @IBOutlet weak var priceLabel: UILabel!
    var selectedShop : ShopModel!
    var quotationIndex : Int!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        receivedServiceBtn.backgroundColor = UIColor.MKColor.Orange
        receivedServiceBtn.setTitleColor(UIColor.MKColor.WhiteColor, forState: UIControlState.Normal)
        ratingView.editable = false
        ratingView.rating = selectedShop.rating!
        repairServiceLabel.text = selectedShop.name
        FontAwesome.Money
//        let unicodeIcon = Character(UnicodeScalar(0xf0d6))
        let unicodeIcon = Character(UnicodeScalar(UInt32(hexString: "f0d6")!))
        priceLabel.text = "\(unicodeIcon) \("ABC")"
//        priceLabel.text = "About $\(selectedShop.quotes![quotationIndex].price as! Int) with your problem"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReceviedServiceTap(sender: UIButton) {

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UInt32 {
    init?(hexString: String) {
        let scanner = NSScanner(string: hexString)
        var hexInt = UInt32.min
        let success = scanner.scanHexInt(&hexInt)
        if success {
            self = hexInt
        } else {
            return nil
        }
    }
}
