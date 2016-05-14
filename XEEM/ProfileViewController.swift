//
//  ProfileViewController.swift
//  XEEM
//
//  Created by Giao Tuan on 12/12/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
import AFNetworking
import FontAwesome_swift
import RealmSwift

class ProfileViewController: UIViewController {
    
    var transportationList = List<Transportation>()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    var currentUser: User!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        let attrs = [
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "SanFranciscoDisplay-Medium", size: 18)!
        ]
        
        //let img = UIImage()
        //self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.titleTextAttributes = attrs
        self.navigationController?.navigationBar.barTintColor = UIColor.MKColor.AppPrimaryColor
        //self.automaticallyAdjustsScrollViewInsets = false
        currentUser = User.currentUser
        setInfo()
        //transportationList.append(Transportation())
        //transportationList.append(Transportation())
        tableView?.dataSource = self
        tableView?.delegate = self
        
    }

    func setInfo() -> () {
        nameLabel.text = currentUser.fullName
        addressLabel.text = currentUser.email

        avatarImage.setImageWithURL(NSURL(string: currentUser.avatarURL!)!)
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.size.width / 2;
        self.avatarImage.clipsToBounds = true;
        transportationList = currentUser.transList ?? List<Transportation>()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func onCloseClicked(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //var labels = ["My Account", "", "Payment", "Logout"]
    static var iconColor = UIColor(hex: 0xE0342F)
    static var iconSize = CGSize(width: 20, height: 20)
    var sectionLabels = [["header": "My Account",
        "data": [
                    [
                        "icon":UIImage.fontAwesomeIconWithName(FontAwesome.CreditCard, textColor: iconColor, size: iconSize),
                        "label": "Payment"
                    ],
                    [
                        "icon":UIImage.fontAwesomeIconWithName(FontAwesome.Key, textColor: iconColor, size: iconSize),
                        "label": "Change password"
                    ]
                ]
        ],
        ["header":"",
        "data": [
                    [
                        "icon": UIImage.fontAwesomeIconWithName(FontAwesome.SignOut, textColor: iconColor, size: iconSize),
                        "label": "Logout"
                    ]
                ]
        ],
        
    ]
}
extension ProfileViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = sectionLabels[section]
        let header = sectionData["header"] as! String

        if(header == "Transportations") {
            return transportationList.count
        }
        
        return sectionData["data"]!.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sectionData = sectionLabels[indexPath.section]
        let header = sectionData["header"] as! String
        
        if(header == "Transportations") {
            let transCell = tableView.dequeueReusableCellWithIdentifier("transCell") as! TransportationTableViewCell
            let model = transportationList[indexPath.row]
            transCell.transportation = model
            
            return transCell
        }
        
        var cell = tableView.dequeueReusableCellWithIdentifier("basicCell") as UITableViewCell!

        let labels = sectionData["data"]
        let object = labels![indexPath.row] as! [String: AnyObject]
        cell!.imageView?.image = object["icon"] as? UIImage
        let label = object["label"] as? String
        cell!.textLabel?.text = label
        
        if label == "Payment" {
            cell.accessoryType = .DisclosureIndicator
        }
        
        if label == "Change password" {
            cell.accessoryType = .DisclosureIndicator
        }
        
        return cell!
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellData = sectionLabels[indexPath.section]
        let labels = cellData["data"]
        let object = labels![indexPath.row] as! [String: AnyObject]
        
        let label = object["label"] as? String
        
        if label == "Logout" {
            // logout code
            logout()
            return
        }
        
        if label == "Payment" {
            // swith to payment screen
            self.performSegueWithIdentifier("paymentSegue", sender: nil)
            return
        }
        
        if label == "Change password" {
            self.performSegueWithIdentifier("changePasswordSegue", sender: nil)
            return
        }
        
    }
    
    func logout(){
        
        User.currentUser = nil
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        
        let vc = storyboard.instantiateViewControllerWithIdentifier("LoginNavigationController") as! UINavigationController
      //  let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.view.window?.rootViewController = vc
       // appDelegate.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//appDelegate.window!.rootViewController = vc
        //appDelegate.window!.makeKeyAndVisible()
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionLabels.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.sectionHeaderHeight
    }
    
    @available(iOS 2.0, *)
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let cellData = sectionLabels[section]
        return cellData["header"] as? String
    }
}
