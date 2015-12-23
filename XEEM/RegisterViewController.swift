//
//  RegisterViewController.swift
//  XEEM
//
//  Created by USER on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailLabel: MKTextField!
    @IBOutlet weak var phoneNumberLabel: MKTextField!
    @IBOutlet weak var registerPasswordLabel: MKTextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var backToLoginBtn: UIButton!
    @IBOutlet weak var XEEM: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRegister()   // register MaterialLabel Desgin
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.initView() // initView
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        self.navigationController?.navigationBarHidden = true
        
    }
    // MARK: - PrivateMethod
    func setRegister() -> () {
        
        UIUtils.setupMaterialTextField(emailLabel)
        UIUtils.setupMaterialTextField(phoneNumberLabel)
        UIUtils.setupMaterialTextField(registerPasswordLabel)
        
    }
    
    func initView() {
        self.XEEM.textColor = ColorUtils.UIColorFromRGB("0xF44336");
        self.view.backgroundColor = ColorUtils.UIColorFromRGB("0xF0F0F0 ")
        self.emailLabel.backgroundColor = UIColor.whiteColor()
        self.phoneNumberLabel.backgroundColor = UIColor.whiteColor()
        self.registerPasswordLabel.backgroundColor = UIColor.whiteColor()
        self.registerBtn.enabled = false
        self.backToLoginBtn.enabled = true
        
        self.registerBtn.backgroundColor = UIColor.clearColor()
        self.registerBtn.layer.borderWidth = CGFloat(Float(1.0))
        self.registerBtn.layer.borderColor = ColorUtils.UIColorFromRGB("0xF44336").CGColor;
        self.registerBtn.layer.cornerRadius = CGFloat(Float(5.0))
        
        self.backToLoginBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.backToLoginBtn.layer.cornerRadius = CGFloat(Float(5.0))
        self.backToLoginBtn.backgroundColor = ColorUtils.UIColorFromRGB("0xF44336");
        self.backToLoginBtn.layer.borderWidth = CGFloat(Float(1.0))
        self.backToLoginBtn.layer.borderColor = ColorUtils.UIColorFromRGB("0xF44336").CGColor;
     
        // delegate
        self.emailLabel.delegate = self;
        self.phoneNumberLabel.delegate = self;
        self.registerPasswordLabel.delegate = self;
        self.registerPasswordLabel.secureTextEntry = true
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func register(sender: AnyObject) {
        
    }
    
    @IBAction func onBackToLoginTap(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
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
