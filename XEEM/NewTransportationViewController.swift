//
//  NewTransportationViewController.swift
//  XEEM
//
//  Created by Giao Tuan on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class NewTransportationViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var typeLabel: MKTextField!
    @IBOutlet weak var nameTextField: MKTextField!
    @IBOutlet weak var plateNumTextField: MKTextField!
    let pickerData = ["Bike","Car", "Motobike"]
    @IBOutlet weak var typePicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        typePicker.delegate = self
        typePicker.dataSource = self
        typeLabel.delegate = self
        setupTextField()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTypeLabelClicked(sender: MKTextField) {
        print("Touch1 textfield")
        typePicker.hidden = false
    }

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return false
    }// return NO to disallow editing.

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeLabel.text = pickerData[row]
        typePicker.hidden = true
    }
    func setupTextField() -> () {
        typeLabel.layer.borderColor = UIColor.clearColor().CGColor
        typeLabel.floatingPlaceholderEnabled = true
        typeLabel.tintColor = UIColor.MKColor.Blue
        typeLabel.rippleLocation = .Right
        typeLabel.cornerRadius = 0
        typeLabel.bottomBorderEnabled = true
        
        nameTextField.layer.borderColor = UIColor.clearColor().CGColor
        nameTextField.floatingPlaceholderEnabled = true
        nameTextField.tintColor = UIColor.MKColor.Blue
        nameTextField.rippleLocation = .Right
        nameTextField.cornerRadius = 0
        nameTextField.bottomBorderEnabled = true
        
        plateNumTextField.layer.borderColor = UIColor.clearColor().CGColor
        plateNumTextField.floatingPlaceholderEnabled = true
        plateNumTextField.tintColor = UIColor.MKColor.Blue
        plateNumTextField.rippleLocation = .Right
        plateNumTextField.cornerRadius = 0
        plateNumTextField.bottomBorderEnabled = true
    }
    @IBAction func onTapOutside(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    @IBAction func onCancelClicked(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func onSaveClicked(sender: UIBarButtonItem) {
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
