//
//  XEEMViewController.swift
//  XEEM
//
//  Created by USER on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit


class XEEMViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signInBtn.enabled = false
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(sender: UIButton) {
        doLogin()
    }
    
    @IBAction func onEditingChanged(sender: UITextField) {
        if sender == self.emailLabel {
            // validate email format
            if self.emailLabel.text?.characters.count > 3 {
                self.emailLabel.textColor = UIColor.blueColor()
            } else {
                self.emailLabel.textColor = UIColor.redColor()
            }

        } else {
            if self.password.text?.characters.count > 1 {
                self.password.textColor = UIColor.blueColor()
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
                            
                            // Dummy Login
                            let storyboard = UIStoryboard(name: "User", bundle: nil)
                            SideMenuController.menuButtonImage = UIImage(named: "menuButton")
                            SideMenuController.presentationStyle = .UnderCenterPanelLeft
                            SideMenuController.animationStyle = .CircleMaskAnimation
                            
                            UINavigationBar.appearance().translucent = false
                            UINavigationBar.appearance().barTintColor = UIColor(hue:0.56, saturation:0.88, brightness:0.95, alpha:1)
                            
                            let rootVC =  storyboard.instantiateViewControllerWithIdentifier("SideMenuController") as! SideMenuController
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
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
