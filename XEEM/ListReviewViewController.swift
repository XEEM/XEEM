//
//  ListReviewViewController.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/22/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class ListReviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var listReview: [ReviewModel] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()        // init tableView
        
    }

    func initTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 20
        self.tableView.registerNib(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: reviewCell)
        self.tableView.allowsSelection = false        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableViewDelegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // service Name
        let cell : ReviewCell = tableView.dequeueReusableCellWithIdentifier(reviewCell, forIndexPath: indexPath) as! ReviewCell
        cell.configCell(listReview[indexPath.row])
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listReview.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    @IBAction func onBackButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
        
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
