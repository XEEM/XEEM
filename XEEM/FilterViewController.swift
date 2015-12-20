//
//  FilterViewController.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let cellFilterIndenfiter = "filterTableViewCell"
    @IBOutlet weak var tableView: UITableView!
    var arrFilterData = [NSDictionary]()
    var arrSelecteData: NSMutableArray = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib(nibName: "FilterCell", bundle: nil), forCellReuseIdentifier: cellFilterIndenfiter)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onApplyClicked(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onCancelClicked(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK - TableViewDelegate
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let filterCell : FilterCell = tableView.dequeueReusableCellWithIdentifier(cellFilterIndenfiter,
            forIndexPath: indexPath) as! FilterCell
        switch indexPath.row {
            case 0:
                filterCell.configData("Car Shop")
            case 1:
                filterCell.configData("Scooter Shop")
            case 2:
                filterCell.configData("Bike Shop")
            case 3:
                filterCell.configData("Motorcycle Shop")
            case 4:
                filterCell.configData("Gas station")
            default: break
        }
        filterCell.imageFilter.image = UIImage(named: "bicycle")
        return filterCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return " "
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var lc : Int = 0
        for number in arrSelecteData {
            if (number as! NSNumber) == indexPath.row {
                arrSelecteData.removeObject(number)
                let cell: FilterCell = tableView.cellForRowAtIndexPath(indexPath) as! FilterCell
                cell.setDefaultImage()
                lc = 1
            }
        }
        if lc == 0 {
            arrSelecteData.addObject(indexPath.row)
            let cell: FilterCell = tableView.cellForRowAtIndexPath(indexPath) as! FilterCell
            cell.setSelectedImage()
        }
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
