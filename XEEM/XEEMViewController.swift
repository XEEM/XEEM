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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(sender: UIButton) {
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
            if self.password.text?.characters.count > 6 {
                self.password.textColor = UIColor.blueColor()
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
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
