//
//  ServiceSummaryViewController.swift
//  XEEM
//
//  Created by USER on 12/21/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ServiceSummaryViewController: UIViewController {

    @IBOutlet weak var serviceSummaryTitle: UILabel!
    
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var avatarService: UIImageView!
    @IBOutlet weak var moneyLabel: UILabel!
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var reviewTextField: MKTextField!
    
    @IBOutlet weak var priceTextField: MKTextField!
    @IBOutlet weak var submitBtn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        reviewTextField.layer.borderColor = UIColor.clearColor().CGColor
        reviewTextField.floatingPlaceholderEnabled = true
        reviewTextField.tintColor = UIColor.MKColor.AppPrimaryColor
        reviewTextField.rippleLocation = .Right
        reviewTextField.cornerRadius = 0
        reviewTextField.bottomBorderEnabled = true
        reviewTextField.textColor =  UIColor.MKColor.WhiteColor
    
        
        priceTextField.layer.borderColor = UIColor.clearColor().CGColor
        priceTextField.floatingPlaceholderEnabled = true
        priceTextField.tintColor = UIColor.MKColor.AppPrimaryColor
        priceTextField.rippleLocation = .Right
        priceTextField.cornerRadius = 0
        priceTextField.bottomBorderEnabled = true
        priceTextField.textColor =  UIColor.MKColor.WhiteColor
        
//        UIUtils.setupMaterialTextField(self.reviewTextField)
        //UIUtils.setupMaterialTextFieldLight(self.priceTextField)
        commentView.layer.shadowOffset = CGSize(width: 3, height: 3)
        commentView.layer.shadowOpacity = 0.7
        commentView.layer.shadowRadius = 2
        commentView.layer.cornerRadius = 10
        self.submitBtn.backgroundColor = UIColor.MKColor.Blue
        self.submitBtn.setTitleColor(UIColor.MKColor.WhiteColor, forState: UIControlState.Normal)


    }

    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSubmitTap(sender: UIButton) {
        // create viewController code...
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("CenterUser") as! UINavigationController
        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("LeftViewController") as! LeftViewController
        let rightViewController = storyboard.instantiateViewControllerWithIdentifier("RightViewController") as! RightViewController
        let slideMenuController = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
        
        let appDelegate = UIApplication.sharedApplication().delegate
        let mainWindow = appDelegate!.window
        mainWindow!!.rootViewController = slideMenuController
        mainWindow!!.makeKeyAndVisible()

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
