//
//  ConfrimViewController.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/22/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

protocol ConfrimViewControllerDelegate {
    func onConfrimTapped(confirmViewController: UIViewController)
    func onCancelTapped(confirmViewController: UIViewController)
}

class ConfrimViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textViewLabel: UITextView!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    var delegate: ConfrimViewControllerDelegate?
    
    @IBAction func onBtnConfirmTapped(sender: UIButton) {
        self.delegate?.onConfrimTapped(self)
    }
    
    @IBAction func onBtnCancelTapped(sender: UIButton) {
        self.delegate?.onCancelTapped(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = "Note for Helper"
        self.textViewLabel.text = ""
        self.view.layer.cornerRadius = 22
        self.view.layer.masksToBounds = true
        self.textViewLabel.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
