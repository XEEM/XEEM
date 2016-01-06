//
//  FinishServiceViewController.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/27/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class FinishServiceViewController: UIViewController {

    @IBOutlet weak var inProcessTitleLabel: UILabel!
    
    @IBOutlet weak var imageAvatarService: UIImageView!
    
    @IBOutlet weak var serviceNameLabel: UILabel!
    
    @IBOutlet weak var ratingView: FloatRatingView!
    
    @IBOutlet weak var finishServiceBtn: UIButton!
    
    var selectedShop : ShopModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.finishServiceBtn.backgroundColor = UIColor.MKColor.Blue
        self.finishServiceBtn.setTitleColor(UIColor.MKColor.WhiteColor, forState: UIControlState.Normal)
        self.ratingView.editable = false
        serviceNameLabel.text = selectedShop.name
        ratingView.rating = selectedShop.rating!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onFinishServiceTap(sender: UIButton) {
//        let storyboard = UIStoryboard(name: "User", bundle: nil)
//        let listReviewVC =  storyboard.instantiateViewControllerWithIdentifier("FinishServiceViewController") as! FinishServiceViewController
//        
//        self.navigationController?.pushViewController(listReviewVC, animated: true)
////            ServiceSummaryViewController
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
