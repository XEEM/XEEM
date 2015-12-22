//
//  ForgotPasswordViewController.swift
//  XEEM
//
//  Created by USER on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailReset: UITextField!

    @IBOutlet weak var resetBtn: UIButton!
    
    @IBOutlet weak var forgotPaswordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.forgotPaswordLabel.textColor = UIColor.lightGrayColor()
        
        self.emailReset.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.emailReset.layer.borderWidth = CGFloat(Float(1.0))
       
        
        self.resetBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.resetBtn.layer.cornerRadius = CGFloat(Float(5.0))
        self.resetBtn.backgroundColor = ColorUtils.UIColorFromRGB("0xF44336");
        self.resetBtn.layer.borderWidth = CGFloat(Float(1.0))
        self.resetBtn.layer.borderColor = ColorUtils.UIColorFromRGB("0xF44336").CGColor;
        
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        

    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func reset(sender: UIButton) {
        
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
