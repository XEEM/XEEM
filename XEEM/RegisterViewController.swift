//
//  RegisterViewController.swift
//  XEEM
//
//  Created by USER on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var email: MKTextField!
    @IBOutlet weak var phoneNumber: MKTextField!
    @IBOutlet weak var registerPassword: MKTextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.registerBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.registerBtn.layer.cornerRadius = CGFloat(Float(5.0))
        self.registerBtn.backgroundColor = ColorUtils.UIColorFromRGB("0xF44336");
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor()
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        setRegister()
        
        // Do any additional setup after loading the view.
    }
    
    func setRegister() -> () {
        
        UIUtils.setupMaterialTextField(email)
        UIUtils.setupMaterialTextField(phoneNumber)
        UIUtils.setupMaterialTextField(registerPassword)
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func register(sender: AnyObject) {
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
