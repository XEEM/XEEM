//
//  RightViewController.swift
//  XEEM
//
//  Created by Giao Tuan on 12/21/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class RightViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let filterList = ["Car services","Bike","MotorBike services","Scooter services","Gas station"]
    var selectedList : [Int]!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        selectedList = defaults.objectForKey("FILTER_KEY") as? [Int] ?? [0,1,2,3]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.MKColor.AppMainColor
        tableView.backgroundView = nil;
        self.tableView.tableFooterView = UIView()
        self.tableView.bounces = false

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
extension RightViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count + 1
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == filterList.count) {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("ApplyFilterCell") as! ApplyFilterCell?
            return cell!
        } else {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("filterServiceCell") as! FilterServiceCell?
            cell!.filterLabel.text = filterList[indexPath.row]
            if selectedList!.contains(indexPath.row) {
                cell!.checkedImageView.image = UIImage(named: "ic_checked")
            } else {
                cell!.checkedImageView.image = UIImage(named: "ic_uncheck")
            }
            return cell!
        }
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("headerFilterCell")
        return headerCell
    }
}
