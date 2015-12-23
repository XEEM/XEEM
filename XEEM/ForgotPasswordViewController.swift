//
//  ForgotPasswordViewController.swift
//  XEEM
//
//  Created by USER on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var emailReset: MKTextField!
    @IBOutlet weak var XEEM: UILabel!
    @IBOutlet weak var forgotPaswordLabel: UILabel!
    
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var backToLoginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.initView() // initView
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        self.navigationController?.navigationBarHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setRegister() -> () {
        
        UIUtils.setupMaterialTextField(emailReset)
    }

    @IBAction func reset(sender: UIButton) {
        
    }
    
    @IBAction func onBackToLoginTap(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func initView() {
        self.XEEM.textColor = ColorUtils.UIColorFromRGB("0xF44336");
        self.view.backgroundColor = ColorUtils.UIColorFromRGB("0xF0F0F0 ")
        self.emailReset.backgroundColor = UIColor.whiteColor()
        self.emailReset.layer.borderWidth = 0
        self.resetBtn.enabled = false
        self.backToLoginBtn.enabled = true
        
        self.resetBtn.backgroundColor = UIColor.clearColor()
        self.resetBtn.layer.borderWidth = CGFloat(Float(1.0))
        self.resetBtn.layer.borderColor = ColorUtils.UIColorFromRGB("0xF44336").CGColor;
        self.resetBtn.layer.cornerRadius = CGFloat(Float(5.0))
        
        self.backToLoginBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.backToLoginBtn.layer.cornerRadius = CGFloat(Float(5.0))
        self.backToLoginBtn.backgroundColor = ColorUtils.UIColorFromRGB("0xF44336");
        self.backToLoginBtn.layer.borderWidth = CGFloat(Float(1.0))
        self.backToLoginBtn.layer.borderColor = ColorUtils.UIColorFromRGB("0xF44336").CGColor;
        
        // delegate
        self.emailReset.delegate = self;
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
