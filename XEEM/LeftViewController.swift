//
//  LeftViewController.swift
//  XEEM
//
//  Created by Giao Tuan on 12/21/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var currentUser: User!
    var listVehicles = [Transportation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = User.currentUser
        listVehicles = currentUser.transList!
        print(currentUser.avatarURL)
        avatarImageView.setImageWithURL(currentUser.avatarURL!);
        UIUtils.setRoundImageView(avatarImageView)
        nameLable.text = currentUser.fullName
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.MKColor.AppMainColor
        tableView.backgroundView = nil;
        self.tableView.tableFooterView = UIView()
        self.tableView.bounces = false
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

extension LeftViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listVehicles.count + 1;
      
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "My Vehicles"
        case 1:
            return "About"
        default:
            return ""
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == listVehicles.count) {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("NewTransCell") as UITableViewCell?
            return cell!
        } else {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("TransportationCell") as UITableViewCell?
            cell?.textLabel?.text = listVehicles[indexPath.row].name
            return cell!
        }
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("headerCell")
        headerCell?.textLabel!.text = "My vehicles"
        headerCell?.detailTextLabel?.text = "\(listVehicles.count)"
        return headerCell
    }
}
