//
//  XEEMViewController.swift
//  XEEM
//
//  Created by Lê Thanh Tân on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
import TKSubmitTransition
import SlideMenuControllerSwift

class XEEMViewController: UIViewController, UITextFieldDelegate, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var emailLabel: MKTextField!
    
    @IBOutlet weak var password: MKTextField!
    
    @IBOutlet weak var signInBtn: TKTransitionSubmitButton!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var forgotPassword: UIButton!
    
    @IBOutlet weak var Xeem: UILabel!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        self.view.layoutIfNeeded()
        super.viewDidLoad()
        
        // init background and blur efect
       backgroundImageView.image = UIImage(named: "background.jpg")
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.alpha = 0.5
        blurView.frame = backgroundImageView.bounds
        backgroundImageView.addSubview(blurView)
        view.sendSubviewToBack(backgroundImageView)
//        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
//        horizontalMotionEffect.minimumRelativeValue = -50
//        horizontalMotionEffect.maximumRelativeValue = 50
//        
//        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
//        verticalMotionEffect.minimumRelativeValue = -50
//        verticalMotionEffect.maximumRelativeValue = 50
//        
//        let motionEffectGroup = UIMotionEffectGroup()
//        motionEffectGroup.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
//        
//        backgroundImageView.addMotionEffect(motionEffectGroup)
        setSignIn()     // set SignIn
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.initView() // initView
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    // MARK: - PrivateMethod
    private func  initView() {
        self.view.backgroundColor = ColorUtils.UIColorFromRGB("0xF0F0F0 ")
        
        self.Xeem.textColor = ColorUtils.UIColorFromRGB("0xF44336");
       // self.forgotPassword.setTitleColor(UIColor.MKColor.Red, forState: .Normal)
       // self.emailLabel.backgroundColor = UIColor.whiteColor()
       // self.password.backgroundColor = UIColor.whiteColor()
        
        self.signInBtn.enabled = false
        self.registerBtn.backgroundColor = UIColor.clearColor()
        self.registerBtn.layer.borderWidth = CGFloat(Float(1.0))
        self.registerBtn.layer.borderColor = ColorUtils.UIColorFromRGB("0xF44336").CGColor;
        self.registerBtn.layer.cornerRadius = CGFloat(Float(5.0))
        
        self.signInBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.signInBtn.layer.cornerRadius = CGFloat(Float(5.0))
        self.signInBtn.backgroundColor = ColorUtils.UIColorFromRGB("0xF44336");
        self.signInBtn.layer.borderWidth = CGFloat(Float(1.0))
        self.signInBtn.layer.borderColor = UIColor.clearColor().CGColor
        
        self.emailLabel.delegate = self;
        self.password.delegate = self;
        self.password.secureTextEntry = true
        
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func setSignIn() -> () {
        
       // UIUtils.setupMaterialTextField(emailLabel)
        //UIUtils.setupMaterialTextField(password)
        UIUtils.setupMaterialTextFieldLight(emailLabel)
        UIUtils.setupMaterialTextFieldLight(password)

    }


    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TKFadeInAnimator(transitionDuration: 0.5, startingAlpha: 0.8)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(sender: UIButton) {
        self.dismissKeyboard()
        signInBtn.startLoadingAnimation()
        self.doLogin()
    }
    
    @IBAction func onEditingChanged(sender: UITextField) {
        if sender == self.emailLabel {
            // validate email format
            if self.emailLabel.text?.characters.count > 3 {
                self.emailLabel.textColor = UIColor.whiteColor()
            } else {
                self.emailLabel.textColor = UIColor.redColor()
            }

        } else {
            if self.password.text?.characters.count > 1 {
                self.password.textColor = UIColor.whiteColor()
            } else {
                self.password.textColor = UIColor.redColor()
            }

        }
        
        if (self.emailLabel.text?.characters.count > 3 &&
            self.password.text?.characters.count > 1) {
            self.signInBtn.enabled = true
        } else {
            self.signInBtn.enabled = false
        }
    }
    
    func doLogin() -> () {
        XEEMService.sharedInstance.login(self.emailLabel.text, passwd: self.password.text) { (token, error) -> () in
                if let token = token {
                    XEEMService.sharedInstance.getUserProfile(token) { (user, error) -> () in
                        print(user)
                        if let user = user {
                            User.currentUser = user
                            
                            // create viewController code...
                            let storyboard = UIStoryboard(name: "User", bundle: nil)
                            
                            let mainViewController = storyboard.instantiateViewControllerWithIdentifier("CenterUser") as! UINavigationController
                            let leftViewController = storyboard.instantiateViewControllerWithIdentifier("LeftViewController") as! LeftCustomerViewController
                            
                            let slideMenuController = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
                          //  let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

                            self.view.window?.rootViewController = slideMenuController
                            
                            self.navigationController?.popToRootViewControllerAnimated(true)

                            
                        } else {
                            // Error from get user data
                        }
                    }
                } else {
                    // Error from login
                }
        }
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
