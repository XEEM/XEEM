//
//  RegisterViewController.swift
//  XEEM
//
//  Created by USER on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
import JBKenBurnsView

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailLabel: MKTextField!
    @IBOutlet weak var phoneNumberLabel: MKTextField!
    @IBOutlet weak var registerPasswordLabel: MKTextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var backgroundView: JBKenBurnsView!
    
    var loading = XHAmazingLoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRegister()   // register MaterialLabel Desgin
        
        // set background
        autoreleasepool { () -> () in
            // set background
            var images = [UIImage]()
            images.append(UIImage(named: "xeem1")!)
            images.append(UIImage(named: "xeem2")!)
            images.append(UIImage(named: "xeem3")!)
            backgroundView.animateWithImages(images, transitionDuration: 10 , initialDelay: 0.1, loop: true, isLandscape: true)
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
            view.insertSubview(blurEffectView, atIndex: 1)
        }
        
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
        self.view.backgroundColor = ColorUtils.UIColorFromRGB("0xF0F0F0 ")
        self.emailLabel.backgroundColor = UIColor.whiteColor()
        self.phoneNumberLabel.backgroundColor = UIColor.whiteColor()
        self.registerPasswordLabel.backgroundColor = UIColor.whiteColor()
        self.registerBtn.enabled = true
        
        self.registerBtn.backgroundColor = UIColor.clearColor()
        self.registerBtn.layer.borderWidth = CGFloat(Float(1.0))
        self.registerBtn.layer.borderColor = ColorUtils.UIColorFromRGB("0xF44336").CGColor;
        self.registerBtn.layer.cornerRadius = CGFloat(Float(5.0))
     
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
        XEEMService.sharedInstance.registerUser(self.emailLabel.text, phone: self.phoneNumberLabel.text, password: self.registerPasswordLabel.text) { (response: AnyObject?, error: NSError?) -> Void in
            print(response)
            let dic: Dictionary = response as! [String:AnyObject]
            let username = dic["Email"] as? String
            let password = dic["Password"] as? String
            XEEMService.sharedInstance.login(username, passwd: password, completion: { (token, error) -> () in
                self.loading.stopAnimating()
                if let token = token {
                    XEEMService.sharedInstance.getUserProfile(token) { (user, error) -> () in
                        print(user)
                        if let user = user {
                            User.currentUser = user
                            let storyboard = UIStoryboard(name: "Login", bundle: nil)
                            let receivedService =  storyboard.instantiateViewControllerWithIdentifier("NewTransportationViewController") as! NewTransportationViewController
                            self.navigationController?.pushViewController(receivedService, animated: true)
                        } else {
                            // Error from get user data
                        }
                    }
                } else {
                    // Error from login
                }
                
            })
        }
    }
    
    func showLoading() {
        loading = XHAmazingLoadingView(type: XHAmazingLoadingAnimationType.Skype)
        loading.loadingTintColor = UIColor.MKColor.Orange
        loading.frame = CGRectMake(0, self.view.bounds.size.width / 2, self.view.bounds.width, 200)
        self.view.addSubview(loading)
        loading.startAnimating()
        
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
