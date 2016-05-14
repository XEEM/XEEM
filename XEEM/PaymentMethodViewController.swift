//
//  PaymentMethodViewController.swift
//  XEEM
//
//  Created by USER on 12/17/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class PaymentMethodViewController: UIViewController {

    @IBOutlet weak var fullname: UITextField!
    
    @IBOutlet weak var cardNumber: UITextField!
    
    @IBOutlet weak var securityCode: UITextField!
    
    @IBOutlet weak var expiryDate: UITextField!
    
    @IBOutlet weak var expiryYear: UITextField!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func paymentMethodSubmit(sender: UIButton) {
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
