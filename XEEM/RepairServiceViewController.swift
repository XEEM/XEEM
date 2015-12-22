//
//  RepairServiceViewController.swift
//  XEEM
//
//  Created by Le Thanh Tan on 12/13/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
let serviceDetailCell = "serviceDetailNameCell"
let quotesCell = "quotesCell"
let showmoreCell = "showmoreCell"
let reviewCell = "reviewCell"

class RepairServiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ShowmoreCellDelegate {
    
    var shopModel: ShopModel?
    var quotesShopSome: [Quotes] = []
    var quotesShopAll: [Quotes] = []
    
    var reviewerAll: [ReviewModel] = []
    var reviewerSome: [ReviewModel] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnXeemMe: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.initTableView()        // init tableView
        self.initData()             // init Data
        self.initView()             // init View

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - PrivateMethod
    private func initTableView() {
        self.title = "Repair Service"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsMultipleSelection = false
        self.tableView.allowsSelection = false
        self.tableView.estimatedRowHeight = 100
        
        self.tableView.registerNib(UINib(nibName: "ServiceDetailNameCell", bundle: nil), forCellReuseIdentifier: serviceDetailCell)
        self.tableView.registerNib(UINib(nibName: "QuotesTableViewCell", bundle: nil), forCellReuseIdentifier: quotesCell)
        self.tableView.registerNib(UINib(nibName: "ShowmoreCell", bundle: nil), forCellReuseIdentifier: showmoreCell)
        self.tableView.registerNib(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: reviewCell)
        
    }
    
    private func initData() {
        if let quotesList = self.shopModel?.quotes {
            quotesShopAll = quotesList
            if quotesShopAll.count > 2 {
                quotesShopSome.append(quotesShopAll[0])
                quotesShopSome.append(quotesShopAll[1])
            }
        }
        
        if let reviewList = self.shopModel?.reviews {
            reviewerAll = reviewList
            if reviewerAll.count > 1 {
                reviewerSome.append(reviewerAll[0])
            }
        }
        
    }
    
    private func initView() {
        self.btnXeemMe.backgroundColor = UIColor.MKColor.Red
        self.btnXeemMe.titleLabel?.textColor = UIColor.whiteColor()
    }
    
    
    
    // MARK: - UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // service Name
            let cell : ServiceDetailNameCell = tableView.dequeueReusableCellWithIdentifier(serviceDetailCell, forIndexPath: indexPath) as! ServiceDetailNameCell
            if let shopModel = shopModel {
                cell.configCell(shopModel)
            }
            return cell
            
        } else if indexPath.section == 1 {
            // Quotes
            if (quotesShopSome.count != quotesShopAll.count && quotesShopSome.count == indexPath.row) {
                let cell : ShowmoreCell = tableView.dequeueReusableCellWithIdentifier(showmoreCell, forIndexPath: indexPath) as! ShowmoreCell
                cell.btnShowMore.setTitle("View More Services", forState: .Normal)
                cell.delegate = self
                cell.tag = 1
                return cell
            }
            // service Name
            let cell : QuotesTableViewCell = tableView.dequeueReusableCellWithIdentifier(quotesCell, forIndexPath: indexPath) as! QuotesTableViewCell
            cell.configCell(self.quotesShopSome[indexPath.row])
            return cell
        } else if indexPath.section == 2 {
            // Reviews
            if (reviewerSome.count != reviewerAll.count && reviewerSome.count == indexPath.row) {
                let cell : ShowmoreCell = tableView.dequeueReusableCellWithIdentifier(showmoreCell, forIndexPath: indexPath) as! ShowmoreCell
                cell.btnShowMore.setTitle("View More Reviews", forState: .Normal)
                cell.delegate = self
                cell.tag = 2
                return cell                
            }
                        
            // service Name
            let cell : ReviewCell = tableView.dequeueReusableCellWithIdentifier(reviewCell, forIndexPath: indexPath) as! ReviewCell
            cell.configCell(reviewerSome[indexPath.row])
            return cell
        }
        
        let cellNil = UITableViewCell()
        return cellNil
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return (self.quotesShopSome.count + 1)
        } else if section == 2 {
            if (reviewerSome.count == reviewerAll.count) {
                return self.reviewerSome.count
            }
            return (self.reviewerSome.count + 1)
        }
        
        return 1
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tempView = UIView.init(frame: CGRectMake(0, 200, 300, 244))
        tempView.backgroundColor = UIColor.clearColor()
        
        let tempLabel = UILabel.init(frame: CGRectMake(15, 0, 300, 44))
        tempLabel.backgroundColor = UIColor.clearColor()
        tempLabel.textColor = UIColor.MKColor.Red
        tempLabel.font = UIFont.boldSystemFontOfSize(18)
        
        // set title
        if section == 1 {
            tempLabel.text = "Services"
        } else if section == 2 {
            tempLabel.text = "Reviews (\(reviewerAll.count))"
        } else {
            tempLabel.text = ""
        }
    
        tempView.addSubview(tempLabel)
        return tempView
    
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 90
        } else if indexPath.section == 1 {
            // view more
            // view detail
            return 45
        } else if indexPath.section == 2 {
            if (reviewerSome.count != reviewerAll.count && reviewerSome.count == indexPath.row) {
                // view more
                return 45
            }
            return 90
        }
        return 90
    }

    
    // MARK: - ShowMoreDelegate
    func onTapShowmoreBtn(showmoreCell: ShowmoreCell) {
        if showmoreCell.tag == 1 {
            // load more quotes
            
        } else if showmoreCell.tag == 2 {
            // load more reviewer
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            let listReviewVC =  storyboard.instantiateViewControllerWithIdentifier("ListReviewViewController") as! ListReviewViewController
            listReviewVC.listReview = self.reviewerAll
            self.navigationController?.pushViewController(listReviewVC, animated: true)
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
