//
//  EditProfileViewController.swift
//  XEEM
//
//  Created by Giao Tuan on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addressTextField: MKTextField!
    @IBOutlet weak var phoneTextField: MKTextField!
    @IBOutlet weak var nameTextField: MKTextField!
    @IBOutlet weak var avatarImageView: UIImageView!
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor();
        currentUser = User.currentUser
        setInfo()
    }

    func setInfo() -> () {
        addressTextField.text = currentUser.address
        nameTextField.text = currentUser.fullName
        phoneTextField.text = currentUser.phone
        avatarImageView.setImageWithURL(currentUser.avatarURL!)
        UIUtils.setRoundImageView(avatarImageView)
        UIUtils.setupMaterialTextField(nameTextField)
        UIUtils.setupMaterialTextField(phoneTextField)
        UIUtils.setupMaterialTextField(addressTextField)
    }
    
    @IBAction func onAvatarTapped(sender: UITapGestureRecognizer) {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .PhotoLibrary
        self.presentViewController(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        avatarImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        UIUtils.setRoundImageView(avatarImageView)
        self.dismissViewControllerAnimated(true, completion: nil)
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
