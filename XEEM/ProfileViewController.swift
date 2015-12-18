//
//  ProfileViewController.swift
//  XEEM
//
//  Created by Giao Tuan on 12/12/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileViewController: UIViewController {
    var transportationList = [Transportation]()
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var currentUser: User!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = ColorUtils.UIColorFromRGB("ffffff");
        self.automaticallyAdjustsScrollViewInsets = false
        currentUser = User.currentUser
        setInfo()
        //transportationList.append(Transportation())
        //transportationList.append(Transportation())
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    func setInfo() -> () {
        nameLabel.text = currentUser.fullName
        addressLabel.text = currentUser.address
        phoneLabel.text = currentUser.phone
        avatarImage.setImageWithURL(currentUser.avatarURL!);
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.size.width / 2;
        self.avatarImage.clipsToBounds = true;
        transportationList = currentUser.transList ?? [Transportation]()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func onCloseClicked(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
extension ProfileViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transportationList.count+1;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == transportationList.count) {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("NewTransCell") as UITableViewCell?
            return cell!
        } else {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("TransportationCell") as! TransportationCell
            cell.nameLabel.text = transportationList[indexPath.row].name
            cell.thumbnailImageView.setImageWithURL(NSURL(string: "http://www.toyotahungvuongsg.com/uploads/8/9/2/4/8924026/6117979_orig.jpeg")!)
            return cell
        }
    }

    @available(iOS 2.0, *)
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "TRANSPORTATION LIST"
    }
}
