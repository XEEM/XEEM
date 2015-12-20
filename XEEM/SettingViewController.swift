//
//  SettingViewController.swift
//  XEEM
//
//  Created by USER on 12/17/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.row == 0 {
//            // inital view controller
//            let vc = PaymentMethodViewController.initialize()
//            // push view controller by navigationController
//            self.navigationController?.pushViewController(vc, animated: true)
//            
//            let cell = tableView.dequeueReusableCellWithIdentifier("PaymentMethod") as! PaymentMethodTableViewCell
//                cell.label.text = "Payment Method"
//                return cell
//        } else if indexPath == 1 {
//            let vc1 = ChangePasswordViewController.initialize()
//            self.navigationController?.pushViewController(vc1, animated: true)
//            
//            let cell = tableView.dequeueReusableCellWithIdentifier("ChangePassword") as! PaymentMethodTableViewCell
//            cell.label.text = "Change Password"
//                return cell
//        } else if indexPath.row == 3 {
//            
//            
//        }
//        
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Currency") as! CurrencyTableViewCell
        cell.currency.text = "Currency"
        cell.USD.text = "USD"
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
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
