//
//  TransportationDetailControllerViewController.swift
//  XEEM
//
//  Created by Giao Tuan on 12/12/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class TransportationDetailControllerViewController: UIViewController, HistoryDetailControlerDelegate {
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var model: Transportation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        bannerImageView.setImageWithURL(NSURL(string: (model?.imageUrls[0])!)!)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50

        // Do any additional setup after loading the view.
        title = model?.name
        let attrs = [
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "SanFranciscoDisplay-Medium", size: 18)!
        ]
        
        //let img = UIImage()
        //self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.titleTextAttributes = attrs
        self.navigationController?.navigationBar.barTintColor = UIColor.MKColor.AppPrimaryColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    @IBAction func onClose(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
extension TransportationDetailControllerViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("HistoryCell") as! HistoryCell
        cell.thumbnailImageView.setImageWithURL(NSURL(string: "http://4.bp.blogspot.com/-6AN1Wg3Nq3Q/Vcm_YvQGQjI/AAAAAAAACfA/F6HIMGYF_Ag/s1600/showroom.jpg")!)
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.displayViewController(.LeftRight)
    }
    
    func displayViewController(animationType: SLpopupViewAnimationType) {
        let myPopupViewController:HistoryDetailControler = HistoryDetailControler(nibName:"HistoryDetailPopup", bundle: nil)
        myPopupViewController.delegate = self
        self.presentpopupViewController(myPopupViewController, animationType: animationType, completion: { () -> Void in
            
        })
    }
    
    func okClicked(sender: HistoryDetailControler) {
        self.dismissPopupViewController(.LeftRight)
    }
    func editClicked(sender: HistoryDetailControler) {
        self.dismissPopupViewController(.LeftRight)
    }


}

