//
//  HistoryDetailControler.swift
//  XEEM
//
//  Created by Giao Tuan on 12/12/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
protocol HistoryDetailControlerDelegate {
    func okClicked(sender: HistoryDetailControler)
    func editClicked(sender: HistoryDetailControler)
}
class HistoryDetailControler: UIViewController {
    @IBOutlet weak var okBtn: UIButton!
    
    @IBOutlet weak var editBtn: UIButton!
    
    var delegate: HistoryDetailControlerDelegate?
    @IBAction func OKClicked(sender: UIButton) {
        delegate!.okClicked(self)
    }
    @IBAction func editClick(sender: UIButton) {
        delegate!.editClicked(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.cornerRadius = 22
        self.view.layer.masksToBounds = true
        self.view.layer.borderColor = UIColor.MKColor.Orange.CGColor
        self.view.layer.borderWidth = 2.0
        
        self.okBtn.layer.cornerRadius = 22
        self.editBtn.layer.cornerRadius = 22
        

        
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textViewShouldReturn(textView: UITextView!) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
