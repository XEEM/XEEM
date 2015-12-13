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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(sender: UIButton) {
        
        
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
