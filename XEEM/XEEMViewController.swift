//
//  XEEMViewController.swift
//  XEEM
//
//  Created by USER on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
import TKSubmitTransition

class XEEMViewController: UIViewController, UITextFieldDelegate, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var emailLabel: MKTextField!
    
    @IBOutlet weak var password: MKTextField!
    
    @IBOutlet weak var signInBtn: TKTransitionSubmitButton!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var forgotPassword: UIButton!
    
    @IBOutlet weak var Xeem: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = ColorUtils.UIColorFromRGB("0xF0F0F0 ")
        
        self.Xeem.textColor = ColorUtils.UIColorFromRGB("0xF44336");
        
        self.emailLabel.backgroundColor = UIColor.whiteColor()
        self.password.backgroundColor = UIColor.whiteColor()
        
        self.forgotPassword.setTitleColor(ColorUtils.UIColorFromRGB("0xF44336"), forState: UIControlState.Normal)
        
        self.signInBtn.enabled = false
        self.signInBtn.setTitleColor(ColorUtils.UIColorFromRGB("0xF44336"), forState: UIControlState.Normal)
        self.signInBtn.layer.borderWidth = CGFloat(Float(1.0))
        self.signInBtn.layer.borderColor = ColorUtils.UIColorFromRGB("0xF44336").CGColor;
        self.signInBtn.layer.cornerRadius = CGFloat(Float(5.0))
    
        self.registerBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.registerBtn.layer.cornerRadius = CGFloat(Float(5.0))
        self.registerBtn.backgroundColor = ColorUtils.UIColorFromRGB("0xF44336");
        self.registerBtn.layer.borderWidth = CGFloat(Float(1.0))
        self.registerBtn.layer.borderColor = ColorUtils.UIColorFromRGB("0xF44336").CGColor;
        
        // Do any additional setup after loading the view.
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.emailLabel.delegate = self;
        self.password.delegate = self;
        
        setSignIn()
        
    }
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func setSignIn() -> () {
        
        UIUtils.setupMaterialTextField(emailLabel)
        UIUtils.setupMaterialTextField(password)
     
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
        doLogin()
        
        signInBtn.animate(1, completion: { () -> () in
            let secondVC = TimelineViewController()
            secondVC.transitioningDelegate = self
            self.presentViewController(secondVC, animated: true, completion: nil)
        })
        
    }
    
    @IBAction func onEditingChanged(sender: UITextField) {
        if sender == self.emailLabel {
            // validate email format
            if self.emailLabel.text?.characters.count > 3 {
                self.emailLabel.textColor = UIColor.lightGrayColor()
            } else {
                self.emailLabel.textColor = UIColor.redColor()
            }

        } else {
            if self.password.text?.characters.count > 6 {
                self.password.textColor = UIColor.lightGrayColor()
            } else {
                self.password.textColor = UIColor.redColor()
            }

        }
        
        if (self.emailLabel.text?.characters.count > 3 &&
            self.password.text?.characters.count > 6) {
            self.signInBtn.enabled = true
        } else {
            self.signInBtn.enabled = false
        }
    }
    
    func doLogin() -> () {
        XEEMService.sharedInstance.login(nil, passwd:
            nil) { (token, error) -> () in
                if let token = token {
                    XEEMService.sharedInstance.getUserProfile(token) { (user, error) -> () in
                        print(user)
                        if let user = user {
                            User.currentUser = user
                            
                            // Dummy Login
                            let storyboard = UIStoryboard(name: "User", bundle: nil)
                            let rootVC =  storyboard.instantiateViewControllerWithIdentifier("SwiftySideMenuViewController") as! SwiftySideMenuViewController
                            
                            let centerVC = storyboard.instantiateViewControllerWithIdentifier("CenterUser");
                            
                            let leftVC = storyboard.instantiateViewControllerWithIdentifier("LeftUser");
                            rootVC.enableLeftSwipeGesture = false
                            rootVC.enableRightSwipeGesture = false
                            
                            rootVC.centerViewController = centerVC
                            rootVC.leftViewController = leftVC
                            rootVC.centerEndScale = 0.8
                            rootVC.leftSpringAnimationSpeed = 20
                            
                            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                            
                            appDelegate.window = UIWindow(frame: UIScreen.mainScreen().bounds)
                            appDelegate.window?.rootViewController = rootVC
                            appDelegate.window?.makeKeyAndVisible()
                            
                        } else {
                            // Error from get user data
                        }
                    }
                } else {
                    // Error from login
                }
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    
    

    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
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
