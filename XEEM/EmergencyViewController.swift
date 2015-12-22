//
//  EmergencyViewController.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/23/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
protocol EmergencyDelegate {
    func emergency(emergencyView: EmergencyViewController, didCancelTap onCancelTap:UIButton)
    func emergency(emergencyView: EmergencyViewController, didHelpTap onHelp:UIButton, whichSelection selection:Int)
    
}

class EmergencyViewController: UIViewController {
    var delegate: EmergencyDelegate?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var btnChoiceFrist: UIButton!
    @IBOutlet weak var btnChoiceSecond: UIButton!
    @IBOutlet weak var btnChoiceThrid: UIButton!
    
    @IBOutlet weak var fristChoiceLabel: UILabel!
    @IBOutlet weak var secondChoiceLabel: UILabel!
    @IBOutlet weak var thirdChoiceLabel: UILabel!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnHelp: UIButton!
    
    
    @IBAction func onCancelTapped(sender: UIButton) {
        self.delegate?.emergency(self, didCancelTap: sender)
    }
    
    @IBAction func onHelpTapped(sender: UIButton) {
        // TO-DO
        self.delegate?.emergency(self, didHelpTap: sender, whichSelection: 0)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
