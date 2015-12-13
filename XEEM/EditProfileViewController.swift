//
//  EditProfileViewController.swift
//  XEEM
//
//  Created by Giao Tuan on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var addressTextField: MKTextField!
    @IBOutlet weak var phoneTextField: MKTextField!
    @IBOutlet weak var nameTextField: MKTextField!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImageView.setImageWithURL(NSURL(string: "http://a5.files.biography.com/image/upload/c_fit,cs_srgb,dpr_1.0,h_1200,q_80,w_1200/MTE5NDg0MDU0NTIzODQwMDE1.jpg")!);
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2;
        avatarImageView.clipsToBounds = true;
        setupTextField()
        
        // Do any additional setup after loading the view.
    }

    func setupTextField() -> () {
        addressTextField.layer.borderColor = UIColor.clearColor().CGColor
        addressTextField.floatingPlaceholderEnabled = true
        addressTextField.tintColor = UIColor.MKColor.Blue
        addressTextField.rippleLocation = .Right
        addressTextField.cornerRadius = 0
        addressTextField.bottomBorderEnabled = true
        addressTextField.text = "Ho Chi Minh city - Vietnam"

        phoneTextField.layer.borderColor = UIColor.clearColor().CGColor
        phoneTextField.floatingPlaceholderEnabled = true
        phoneTextField.tintColor = UIColor.MKColor.Blue
        phoneTextField.rippleLocation = .Right
        phoneTextField.cornerRadius = 0
        phoneTextField.bottomBorderEnabled = true
        phoneTextField.text = "0909090900"
        
        nameTextField.layer.borderColor = UIColor.clearColor().CGColor
        nameTextField.floatingPlaceholderEnabled = true
        nameTextField.tintColor = UIColor.MKColor.Blue
        nameTextField.rippleLocation = .Right
        nameTextField.cornerRadius = 0
        nameTextField.bottomBorderEnabled = true
        nameTextField.text = "Denns"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSaveClicked(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)    }
    @IBAction func onCancelClick(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
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
