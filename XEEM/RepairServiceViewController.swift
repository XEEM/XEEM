//
//  RepairServiceViewController.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class RepairServiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let serviceDetailCell = "serviceDetailNameCell"
    let quotesCell = "quotesCell"
    let showmoreCell = "showmoreCell"
    let reviewCell = "reviewCell"

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Repair Service"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib(nibName: "ServiceDetailNameCell", bundle: nil), forCellReuseIdentifier: serviceDetailCell)
        self.tableView.registerNib(UINib(nibName: "QuotesTableViewCell", bundle: nil), forCellReuseIdentifier: quotesCell)
        self.tableView.registerNib(UINib(nibName: "ShowmoreCell", bundle: nil), forCellReuseIdentifier: showmoreCell)
        self.tableView.registerNib(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: reviewCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // service Name
            let cell : ServiceDetailNameCell = tableView.dequeueReusableCellWithIdentifier(serviceDetailCell, forIndexPath: indexPath) as! ServiceDetailNameCell
            let data = NSDictionary()
            cell.configCell(data)
            return cell
            
        } else if indexPath.section == 1 {
            // Quotes
            if indexPath.row <= 3 {
                // service Name
                let cell : QuotesTableViewCell = tableView.dequeueReusableCellWithIdentifier(quotesCell, forIndexPath: indexPath) as! QuotesTableViewCell
                let data = NSDictionary()
                cell.configCell(data)
                return cell
            } else {
                // show more 
                let cell : ShowmoreCell = tableView.dequeueReusableCellWithIdentifier(showmoreCell, forIndexPath: indexPath) as! ShowmoreCell
                return cell
            }
        } else if indexPath.section == 2 {
            // Reviews
            if indexPath.row == 0 {
                // service Name
                let cell : ReviewCell = tableView.dequeueReusableCellWithIdentifier(reviewCell, forIndexPath: indexPath) as! ReviewCell
                let data = NSDictionary()
                cell.configCell(data)
                return cell
                
            }
            
        }
        
        let cellNil = UITableViewCell()
        return cellNil
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 5
        } else if section == 2 {
            return 1
        }
        
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Quotes"
        } else if section == 2 {
            return "Review"
        }
        
        return ""
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 90
        } else if indexPath.section == 1 {
            return 50
        }
        return 90
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
