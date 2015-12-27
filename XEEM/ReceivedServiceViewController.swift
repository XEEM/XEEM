//
//  ReceivedServiceViewController.swift
//  XEEM
//
//  Created by USER on 12/21/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class ReceivedServiceViewController: UIViewController {

    @IBOutlet weak var requestAccepetedTitleLabel: UILabel!
    
    @IBOutlet weak var imageRepairService: UIImageView!
    
    @IBOutlet weak var repairServiceLabel: UILabel!
    
    @IBOutlet weak var ratingView: FloatRatingView!
    
    @IBOutlet weak var receivedServiceBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.receivedServiceBtn.backgroundColor = UIColor.MKColor.Orange
        self.receivedServiceBtn.setTitleColor(UIColor.MKColor.WhiteColor, forState: UIControlState.Normal)
        self.ratingView.editable = false
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
