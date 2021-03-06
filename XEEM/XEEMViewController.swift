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
import JBKenBurnsView

class XEEMViewController: UIViewController, UITextFieldDelegate, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var emailLabel: MKTextField!
    
    @IBOutlet weak var password: MKTextField!
    
    @IBOutlet weak var signInBtn: TKTransitionSubmitButton!    
    
    @IBOutlet weak var forgotPassword: UIButton!

    @IBOutlet weak var btnFacebook: UIButton!
    
    @IBOutlet weak var btnGoogle: UIButton!
    
    @IBOutlet weak var backgroundView: JBKenBurnsView!
    
    
    override func viewDidLoad() {
        self.view.layoutIfNeeded()
        super.viewDidLoad()
        self.btnFacebook.setTitleColor(UIColor.MKColor.WhiteColor, forState: UIControlState.Normal)
        self.btnFacebook.backgroundColor = UIColor.MKColor.Blue
        
        self.btnGoogle.setTitleColor(UIColor.MKColor.WhiteColor, forState: UIControlState.Normal)
        self.btnGoogle.backgroundColor = UIColor.MKColor.Orange
        
        self.forgotPassword.setTitleColor(UIColor.MKColor.WhiteColor, forState: UIControlState.Normal)
        
        // init background and blur efect
        // set background
        
        autoreleasepool { () -> () in
            // set background
            var images = [UIImage]()
            images.append(UIImage(named: "xeem1")!)
            images.append(UIImage(named: "xeem2")!)
            images.append(UIImage(named: "xeem3")!)
            backgroundView.animateWithImages(images, transitionDuration: 3 , initialDelay: 0.1, loop: true, isLandscape: true)
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
            view.insertSubview(blurEffectView, atIndex: 1)
        }

        
        
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
        self.navigationController?.navigationBarHidden = true
    }
    
    // MARK: - PrivateMethod
    private func  initView() {
        self.view.backgroundColor = ColorUtils.UIColorFromRGB("0xF0F0F0 ")
        

       // self.forgotPassword.setTitleColor(UIColor.MKColor.Red, forState: .Normal)
       // self.emailLabel.backgroundColor = UIColor.whiteColor()
       // self.password.backgroundColor = UIColor.whiteColor()
        
        self.signInBtn.enabled = false
        
        self.signInBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.signInBtn.layer.cornerRadius = CGFloat(Float(5.0))
        self.signInBtn.backgroundColor = UIColor.MKColor.Orange
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
    
    @IBAction func onBackTap(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
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
                            let leftViewController = storyboard.instantiateViewControllerWithIdentifier("LeftViewController") as! LeftViewController
                            let rightViewController = storyboard.instantiateViewControllerWithIdentifier("RightViewController") as! RightViewController
                            
                            let slideMenuController = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
                          //  let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

                            self.view.window?.rootViewController = slideMenuController
                           // appDelegate.window = UIWindow(frame: UIScreen.mainScreen().bounds)
                           // appDelegate.window!.rootViewController = slideMenuController
//                            appDelegate.window?.makeKeyAndVisible()
                            
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
