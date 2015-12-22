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
    let filterList = ["Car services","Bike Services","MotorBike services","Scooter services","Gas station"]
    var selectedList : [Int]!
    var delegate : RightViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        selectedList = defaults.objectForKey("FILTER_KEY") as? [Int] ?? [0,1,2,3,4]
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
    
    func convertFilter(intList: [Int]!) -> [Character] {
        var charList = [Character]()
        for intValue in intList {
            switch intValue {
            case 0:
                charList.append("C")
                break
            case 1:
                charList.append("B")
                break
            case 2:
                charList.append("M")
                break
            case 3:
                charList.append("S")
                break
            case 4:
                charList.append("G")
                break
            default:
                break
            
            }
        }
        return charList
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
extension RightViewController: UITableViewDataSource, UITableViewDelegate, ApplyFilterCellDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count + 1
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == filterList.count) {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("ApplyFilterCell") as! ApplyFilterCell?
            cell!.delegate = self
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
    
    // handle action when click apply
    func applyFilterCell(filterCell : ApplyFilterCell) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(selectedList, forKey: "FILTER_KEY")
        self.slideMenuController()?.toggleRight()
        delegate?.rightViewController(self,filterChange: selectedList)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row < filterList.count) {
            if selectedList!.contains(indexPath.row) {
                selectedList = selectedList.filter() {$0 != indexPath.row}
            } else {
                selectedList.append(indexPath.row)
                selectedList.sortInPlace()
            }
            tableView.reloadData()
        }
    }
}


protocol RightViewControllerDelegate {
    func rightViewController(rightViewController : RightViewController, filterChange listFilter: [Int]!)
}
